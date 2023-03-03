import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:flutter_flame_showcase/main.dart';

class GameMenuOverlay extends StatefulWidget {
  const GameMenuOverlay(this.game, {super.key});

  final Game game;

  @override
  State<GameMenuOverlay> createState() => _GameMenuOverlayState();
}

class _GameMenuOverlayState extends State<GameMenuOverlay> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage("assets/images/home.png"),
          fit: BoxFit.cover,
        ),
      ),
      child: Stack(children: [
        Positioned(
          bottom: 20,
          left: (widget.game as MortalKombat).size.y / 2 + 50,
          child: Center(
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(fixedSize: const Size(300, 180), backgroundColor: Colors.deepOrange),
              onPressed: () {
                (widget.game as MortalKombat).startGame();
              },
              child: const Text(
                "Play",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 32,
                ),
              ),
            ),
          ),
        ),
      ]),
    );
  }
}
