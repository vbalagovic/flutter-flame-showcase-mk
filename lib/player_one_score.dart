import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:flutter_flame_showcase/main.dart';

class PlayerOneScore extends StatefulWidget {
  const PlayerOneScore(this.game, {super.key});

  final Game game;
  @override
  State<PlayerOneScore> createState() => _PlayerOneScoreState();
}

class _PlayerOneScoreState extends State<PlayerOneScore> {
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: (widget.game as MortalKombat).gameManager.playerOne,
        builder: (context, value, child) {
          return Column(
            children: [
              const Text(
                "Player One",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 32,
                ),
              ),
              Text(
                value.toString(),
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 32,
                ),
              ),
            ],
          );
        });
  }
}
