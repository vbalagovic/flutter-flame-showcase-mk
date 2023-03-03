
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/sprite.dart';
import 'package:flutter_flame_showcase/main.dart';
import 'package:flutter_flame_showcase/player_liu.dart';
import 'package:flutter_flame_showcase/players.dart';

class Ice extends SpriteAnimationComponent with HasGameRef<MortalKombat>, CollisionCallbacks {
  Ice({this.selectedPlayer, this.speed})
      : super(
          size: Vector2(100, 100),
          anchor: Anchor.bottomLeft,
          priority: 2,
        );
  Vector2 velocity = Vector2(700, 1);
  dynamic selectedPlayer;
  dynamic speed;
  dynamic currentPlayer;

  @override
  Future<void> onLoad() async {
    //debugMode = true;
    add(CircleHitbox()..debugPaint.strokeWidth = 2);

    final spriteSheet = SpriteSheet(
      image: await gameRef.images.load('ice.png'),
      srcSize: Vector2(50, 100),
    );

    animation = spriteSheet.createAnimation(row: 0, stepTime: 0.3, to: 5, loop: false);
    currentPlayer = selectedPlayer ?? gameRef.player;
    position = Vector2(currentPlayer.position.x, currentPlayer.position.y - (currentPlayer.size.y / 2));
    await super.onLoad();
  }

  @override
  void onGameResize(Vector2 sized) {
    size = Vector2(sized.x / 10, sized.y / 7);
    super.onGameResize(sized);
  }

  @override
  void update(double dt) {
    if (speed != null) {
      velocity = Vector2(speed, 1);
    }
    position += velocity * dt;

    if (position.x > gameRef.size.x) {
      removeFromParent();
      return;
    }

    super.update(dt);
  }

  @override
  void onCollision(Set<Vector2> intersectionPoints, PositionComponent other) async {
    if (currentPlayer == other) {
      return;
    }
    if (other is PlayerLiu) {
      removeFromParent();
      gameRef.gameManager.decreasePlayerTwo();
      return;
    }
    if (other is Player) {
      removeFromParent();
      gameRef.gameManager.decreasePlayerOne();
      return;
    }
    super.onCollision(intersectionPoints, other);
  }
}
