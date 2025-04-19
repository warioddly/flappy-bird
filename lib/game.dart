import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:flappy_bird/overlays/fps.dart';
import 'package:flappy_bird/overlays/score_overlay.dart';
import 'package:flappy_bird/world/world.dart';

class FlappyBirdGame extends FlameGame with HasKeyboardHandlerComponents, HasCollisionDetection {

  FlappyBirdGame({super.camera});

  bool get isPaused => paused;

  final _scoreOverlay = ScoreOverlay();

  int get score => _scoreOverlay.score;

  @override
  Future<void> onLoad() async {
    await super.onLoad();
    await addAll([
      world = MyWorld(),
      FrameRateOverlay(),
    ]);
    await world.add(_scoreOverlay);
  }

  void pause() {
    paused = true;
  }

  void resume() {
    paused = false;
  }

  void togglePause() {
    if (isPaused) {
      resume();
    } else {
      pause();
    }
  }

  void restart() {
    paused = false;
    overlays.removeAll(['restart']);
     _scoreOverlay.reset();
    onLoad();
  }

  void incrementScore() {
    _scoreOverlay.increment();
  }

}
