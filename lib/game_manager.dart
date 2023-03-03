import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import 'package:flutter_flame_showcase/main.dart';

class GameManager extends Component with HasGameRef<MortalKombat> {
  GameManager();

  ValueNotifier<int> playerOne = ValueNotifier(10);
  ValueNotifier<int> playerTwo = ValueNotifier(10);
  GameState state = GameState.intro;

  bool get isPlaying => state == GameState.playing;
  bool get isGameOver => state == GameState.gameOver;
  bool get isIntro => state == GameState.intro;

  void reset() {
    playerOne.value = 10;
    playerTwo.value = 10;

    state = GameState.intro;
  }

  void decreasePlayerOne() {
    playerOne.value--;
    if (playerOne.value <= 0) {
      state = GameState.gameOver;
      gameRef.onLose();
    }
  }

  void decreasePlayerTwo() {
    playerTwo.value--;
    if (playerTwo.value <= 0) {
      state = GameState.gameOver;
      gameRef.onLose();
    }
  }
}

enum GameState { intro, playing, gameOver }
