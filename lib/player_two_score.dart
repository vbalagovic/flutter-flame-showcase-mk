import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:flutter_flame_showcase/main.dart';

class PlayerTwoScore extends StatefulWidget {
  const PlayerTwoScore(this.game, {super.key});

  final Game game;
  @override
  State<PlayerTwoScore> createState() => _PlayerTwoScoreState();
}

class _PlayerTwoScoreState extends State<PlayerTwoScore> {
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: (widget.game as MortalKombat).gameManager.playerTwo,
        builder: (context, value, child) {
          return Column(
            children: [
              const Text(
                "Player Two",
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
