import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:flappy_bird/overlays/fps.dart';
import 'package:flappy_bird/overlays/score_overlay.dart';
import 'package:flappy_bird/world/world.dart';

class FlappyBirdGame extends FlameGame with HasKeyboardHandlerComponents, HasCollisionDetection {

  FlappyBirdGame({super.camera});

  bool _isPaused = true;

  bool get isPaused => _isPaused;

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

  @override
  void update(double dt) {
    // if (isPaused) return;
    super.update(dt);
  }

  void pause() {
    _isPaused = true;
    if (overlays.isActive('pause')) return;
    overlays.add('pause');
  }

  void resume() {
    _isPaused = false;
    if (overlays.isActive('pause')) {
      overlays.remove('pause');
    }
  }

  void togglePause() {
    if (isPaused) {
      resume();
    } else {
      pause();
    }
  }

  void restart() {
    _isPaused = false;
    overlays.removeAll(['pause', 'restart']);
     _scoreOverlay.reset();
    onLoad();
  }

  void incrementScore() {
    _scoreOverlay.increment();
  }

}
