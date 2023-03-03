import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flutter/services.dart';
import 'package:flutter_flame_showcase/ice.dart';
import 'package:flutter_flame_showcase/main.dart';
import 'package:flutter_flame_showcase/player_liu.dart';

enum PlayerState { regular, duck, left, right, jump, hit, shoot }

class Player extends SpriteAnimationGroupComponent with KeyboardHandler, HasGameRef, CollisionCallbacks {
  Player({size})
      : super(
          size: Vector2(150, 300),
          anchor: Anchor.bottomLeft,
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
    //flipHorizontally();
    //current = PlayerState.regular;
    position = Vector2(size.x, gameRef.size.y - 10);
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
    if (other is PlayerLiu && current == PlayerState.hit) {
      (gameRef as MortalKombat).gameManager.decreasePlayerTwo();

      return;
    }

    super.onCollision(intersectionPoints, other);
  }

  Future<void> _loadCharacterSprites() async {
    final regular = await gameRef.loadSpriteAnimation(
        'spritesheet.png',
        SpriteAnimationData.sequenced(
          amount: 7,
          textureSize: Vector2(63.4, 130.0),
          stepTime: 0.15,
          loop: true,
        ));

    final right = await gameRef.loadSpriteAnimation(
        'left.png',
        SpriteAnimationData.sequenced(
          amount: 5,
          textureSize: Vector2(63.4, 130.0),
          stepTime: 0.20,
          loop: true,
        ));

    final left = await gameRef.loadSpriteAnimation(
        'right.png',
        SpriteAnimationData.sequenced(
          amount: 5,
          textureSize: Vector2(63.4, 130.0),
          stepTime: 0.20,
          loop: true,
        ));

    final jump = await gameRef.loadSpriteAnimation(
        'jump.png',
        SpriteAnimationData.sequenced(
          amount: 3,
          textureSize: Vector2(70.4, 130.0),
          stepTime: .2,
          loop: false,
        ));

    final hit = await gameRef.loadSpriteAnimation(
        'hit.png',
        SpriteAnimationData.sequenced(
          amount: 3,
          textureSize: Vector2(73.4, 110.0),
          stepTime: 0.20,
          loop: false,
        ));

    final shoot = await gameRef.loadSpriteAnimation(
        'shoot.png',
        SpriteAnimationData.sequenced(
          amount: 3,
          textureSize: Vector2(90.4, 110.0),
          stepTime: 0.20,
          loop: false,
        ));

    final player = SpriteAnimationGroupComponent<PlayerState>(animations: {
      PlayerState.regular: regular,
      PlayerState.left: left,
      PlayerState.right: right,
      PlayerState.jump: jump,
      PlayerState.hit: hit,
      PlayerState.shoot: shoot,

      //PlayerState.duck: duck,
    }, current: PlayerState.regular);
    animations = player.animations;

    current = PlayerState.regular;
  }

  @override
  bool onKeyEvent(RawKeyEvent event, Set<LogicalKeyboardKey> keysPressed) {
    final isKeyUp = event is RawKeyUpEvent;
    //
    if (isKeyUp) {
      if (current == PlayerState.right || current == PlayerState.left || current == PlayerState.jump) {
        stop();
        current = PlayerState.regular;
      }
    }
    if (keysPressed.contains(LogicalKeyboardKey.arrowLeft)) {
      current = PlayerState.left;
      moveLeft();
    }

    if (keysPressed.contains(LogicalKeyboardKey.arrowRight)) {
      current = PlayerState.right;
      moveRight();
    }

    // During development, its useful to "cheat"
    if (keysPressed.contains(LogicalKeyboardKey.arrowUp)) {
      current = PlayerState.jump;
      moveUp();
    }

    if (keysPressed.contains(LogicalKeyboardKey.arrowDown)) {
      moveDown();
    }

    if (keysPressed.contains(LogicalKeyboardKey.space)) {
      current = PlayerState.hit;
      Future.delayed(const Duration(milliseconds: 99), () {
        if (current == PlayerState.hit) {
          current = PlayerState.regular;
        }
      });
    }

    if (keysPressed.contains(LogicalKeyboardKey.shiftLeft)) {
      current = PlayerState.shoot;
      final ice = Ice();
      (gameRef as MortalKombat).add(ice);
    }

    return true;
  }
}
