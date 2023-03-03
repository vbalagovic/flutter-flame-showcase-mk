import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:flutter_flame_showcase/player_one_score.dart';
import 'package:flutter_flame_showcase/player_two_score.dart';

class GameOverlay extends StatefulWidget {
  const GameOverlay(this.game, {super.key});

  final Game game;

  @override
  State<GameOverlay> createState() => _GameOverlayState();
}

class _GameOverlayState extends State<GameOverlay> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          top: 50,
          left: 130,
          child: PlayerOneScore(widget.game)
        ),
        Positioned(
          top: 50,
          right: 130,
          child: PlayerTwoScore(widget.game)
        ),
      ]
    );
  }
}