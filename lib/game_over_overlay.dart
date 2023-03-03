import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:flutter_flame_showcase/main.dart';

class GameOverOverlay extends StatefulWidget {
  const GameOverOverlay(this.game, {super.key});

  final Game game;

  @override
  State<GameOverOverlay> createState() => _GameOverOverlayState();
}

class _GameOverOverlayState extends State<GameOverOverlay> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.transparent,
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(child: Text((widget.game as MortalKombat).gameManager.playerOne.value <= 0 ? 'Player Two Wins' : 'Player One Wins', style: const TextStyle(
              color: Colors.white,
              fontSize: 32,
            ),),),
          Center(
            child: ElevatedButton(
              onPressed: () {
                (widget.game as MortalKombat).overlays.add("gameMenuOverlay");
              },
              child: const Text('Menu'),
            ),
          ),
        ]
      ),
    );
  }
}