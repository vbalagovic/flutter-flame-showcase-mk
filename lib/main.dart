import 'dart:developer';

import 'package:flame/game.dart';
import 'package:flame/input.dart';
import 'package:flame_audio/flame_audio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_flame_showcase/game_manager.dart';
import 'package:flutter_flame_showcase/game_menu_overlay.dart';
import 'package:flutter_flame_showcase/game_over_overlay.dart';
import 'package:flutter_flame_showcase/game_overlay.dart';
import 'package:flutter_flame_showcase/mk_world.dart';
import 'package:flutter_flame_showcase/player_liu.dart';
import 'package:flutter_flame_showcase/players.dart';

void main() {
  runApp(const MortalKombatGame());
}

class MortalKombatGame extends StatefulWidget {
  const MortalKombatGame({super.key});

  @override
  State<MortalKombatGame> createState() => _MortalKombatGameState();
}

class _MortalKombatGameState extends State<MortalKombatGame> {
  final game = MortalKombat();

  @override
  Widget build(BuildContext context) {
    return GameWidget(
      game: game,
      overlayBuilderMap: <String, Widget Function(BuildContext, Game)>{
        'gameOverlay': (context, game) => GameOverlay(game),
        'gameMenuOverlay': (context, game) => GameMenuOverlay(game),
        'gameOverOverlay': (context, game) => GameOverOverlay(game),
      },
      initialActiveOverlays: const ['gameMenuOverlay'],
    );
  }
}

class MortalKombat extends FlameGame with HasCollisionDetection, HasKeyboardHandlerComponents {
  final world = MkWorld();
  final player = Player();
  final liu = PlayerLiu();
  final GameManager gameManager = GameManager();

  @override
  void onMount() {
    log("on MOUNT");
    super.onMount();
  }

  @override
  Future<void> onLoad() async {
    FlameAudio.bgm.play('theme.mp3');
    // Add world to game, parallax background will be loaded
    await add(world);
    await add(gameManager);
  }

  @override
  void update(double dt) {
    if (gameManager.isGameOver) {
      // next tick to remove components
      if (children.contains(player) || children.contains(liu)) {
        gameManager.children.forEach((element) {
          element.removeFromParent();
        });
        super.update(dt);
      }

      return;
    }

    if (gameManager.isIntro) {
      overlays.add('gameMenuOverlay');
      return;
    }

    super.update(dt);
  }

  void startGame() async {
    gameManager.reset();
    gameManager.state = GameState.playing;

    await add(player);
    await add(liu);

    overlays.add('gameOverlay');
    overlays.remove('gameMenuOverlay');
    overlays.remove('gameOverOverlay');
  }

  void onLose() {
    if (children.contains(player)) player.removeFromParent();
    if (children.contains(liu)) liu.removeFromParent();
    overlays.add('gameOverOverlay');
    overlays.remove("gameOverlay");
  }
}
