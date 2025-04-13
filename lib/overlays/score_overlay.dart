
import 'dart:async';
import 'package:flame/components.dart';
import 'package:flappy_bird/game.dart';

class ScoreOverlay extends TextComponent with HasGameRef<FlappyBirdGame> {

  int _score = 0;

  int get score => _score;

  @override
  FutureOr<void> onLoad() async {
    await super.onLoad();
    final size = game.canvasSize;
    text = 'Score: $_score';
    center = Vector2(size.x / 2, size.y / 5);
    position = Vector2(0 , -size.y / 3) ;
    priority = 2;
    anchor = Anchor.center;
  }

  void increment() {
    _changeScore(++_score);
  }

  void reset() {
    _changeScore(_score = 0);
  }

  void _changeScore(int score) {
    _score = score;
    text = 'Score: $_score';
  }

}