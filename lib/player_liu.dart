
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flutter/services.dart';
import 'package:flutter_flame_showcase/ice.dart';
import 'package:flutter_flame_showcase/main.dart';
import 'package:flutter_flame_showcase/players.dart';

enum PlayerLiuState { regular, duck, left, right, jump, hit, shoot }

class PlayerLiu extends SpriteAnimationGroupComponent with KeyboardHandler, HasGameRef, CollisionCallbacks {
  PlayerLiu({size})
      : super(
          size: Vector2(150, 300),
          anchor: Anchor.bottomCenter,
          priority: 2,
        );
  Vector2 _velocity = Vector2.zero();
  double _hAxisInput = 0;
  double _yAxisInput = 0;
  int customVelocity = 5;
  final double movingLeftInput = -200;
  final double movingUpInput = 100;
  final double movingRightInput = 200;
  double jumpSpeed = 50;
  final double _gravity = 8;

  @override
  Future<void> onLoad() async {
    //debugMode = true;
    add(RectangleHitbox()..debugPaint.strokeWidth = 2);
    await super.onLoad();

    await _loadCharacterSprites();
    flipHorizontally();
    //current = PlayerLiuState.regular;
    position = Vector2(gameRef.size.x, gameRef.size.y - 10);
  }

  @override
  void onGameResize(Vector2 sized) {
    size = Vector2(sized.x / 10, sized.y / 2.8);
    super.onGameResize(sized);
  }

  @override
  void update(double dt) {
    _velocity.x = _hAxisInput;

    _velocity.y = _yAxisInput * _gravity;

    position += _velocity * dt * 2;

    // Make sure that the player never goes outside of the screen in the Y-axis
    if (position.y > gameRef.size.y - 10) {
      position.y = gameRef.size.y - 10;
    }
    if (position.y < 300) {
      moveDown();
    }
    // Make sure that the player never goes outside of the screen in the X-axis
    if (position.x < 0) {
      position.x = 0;
    }
    if (position.x > gameRef.size.x - 200) {
      position.x = gameRef.size.x - 200;
    }

    super.update(dt);
  }

  void jump() {
    _yAxisInput = -jumpSpeed;
  }

  void moveLeft() {
    _hAxisInput = 0; // by default not going left or right
    _hAxisInput += movingLeftInput;
  }

  void moveDown() {
    _yAxisInput = 0;
    _yAxisInput += movingRightInput;
  }

  void moveUp() {
    jump();
  }

  void moveRight() {
    _hAxisInput = 0; // by default not going left or right
    _hAxisInput += movingRightInput;
  }

  void stop() {
    _hAxisInput = 0;
    //_yAxisInput = 0;
  }

  void reset() {
    _velocity = Vector2.zero();
  }

  void resetPosition() {
    position = gameRef.size;
  }

  @override
  void onCollision(Set<Vector2> intersectionPoints, PositionComponent other) async {
    if (other is Player && other.current == PlayerState.hit) {
      position = position + Vector2(100, -50);
      current = PlayerLiuState.right;
      jump();
    }

    super.onCollision(intersectionPoints, other);
  }

  Future<void> _loadCharacterSprites() async {
    final regular = await gameRef.loadSpriteAnimation('spritesheet.png', SpriteAnimationData.sequenced(
      amount: 6,
      //texturePosition: Vector2(15, 0),
      textureSize: Vector2(63.4, 130.0),
      stepTime: 0.15,
      loop: true,
    ));

    final left = await gameRef.loadSpriteAnimation('left.png', SpriteAnimationData.sequenced(
      amount: 5,
      textureSize: Vector2(63.4, 130.0),
      stepTime: 0.20,
      loop: true,
    ));

    final right = await gameRef.loadSpriteAnimation('right.png', SpriteAnimationData.sequenced(
      amount: 5,
      textureSize: Vector2(63.4, 130.0),
      stepTime: 0.20,
      loop: true,
    ));

    final jump = await gameRef.loadSpriteAnimation('jump.png', SpriteAnimationData.sequenced(
      amount: 3,
      textureSize: Vector2(70.4, 130.0),
      stepTime: .2,
      loop: false,
    ));

    final hit = await gameRef.loadSpriteAnimation('hit.png', SpriteAnimationData.sequenced(
      amount: 3,
      textureSize: Vector2(73.4, 110.0),
      stepTime: 0.20,
      loop: false,
    ));

    final shoot = await gameRef.loadSpriteAnimation('shoot.png', SpriteAnimationData.sequenced(
      amount: 3,
      textureSize: Vector2(90.4, 110.0),
      stepTime: 0.20,
      loop: false,
    ));


    final player = SpriteAnimationGroupComponent<PlayerLiuState>(animations: {
      PlayerLiuState.regular: regular,
      PlayerLiuState.left: left,
      PlayerLiuState.right: right,
      PlayerLiuState.jump: jump,
      PlayerLiuState.hit: hit,
      PlayerLiuState.shoot: shoot,

      //PlayerLiuState.duck: duck,
    }, current: PlayerLiuState.regular);
    animations = player.animations;

    current = PlayerLiuState.regular;

  }

  @override
  bool onKeyEvent(RawKeyEvent event, Set<LogicalKeyboardKey> keysPressed) {
    final isKeyUp = event is RawKeyUpEvent;
    //
    if (isKeyUp) {
      if (current == PlayerLiuState.right || current == PlayerLiuState.left || current == PlayerLiuState.jump) {
          stop();
          current = PlayerLiuState.regular;
      }

    }
    if (keysPressed.contains(LogicalKeyboardKey.keyA)) {
      current = PlayerLiuState.right;
      moveLeft();
    }

    if (keysPressed.contains(LogicalKeyboardKey.keyD)) {
        current = PlayerLiuState.left;
        moveRight();
    }

    // During development, its useful to "cheat"
    if (keysPressed.contains(LogicalKeyboardKey.keyW)) {
      current = PlayerLiuState.jump;
      moveUp();
    }

    if (keysPressed.contains(LogicalKeyboardKey.keyS)) {
      moveDown();
    }

    if (keysPressed.contains(LogicalKeyboardKey.enter)) {
      current = PlayerLiuState.hit;
    }

    if (keysPressed.contains(LogicalKeyboardKey.shiftRight)) {
      current = PlayerLiuState.shoot;
      final ice = Ice(selectedPlayer: (gameRef as MortalKombat).liu, speed: -700);
      ice.flipHorizontally();
      (gameRef as MortalKombat).add(ice);
    }

    return true;
  }
}
