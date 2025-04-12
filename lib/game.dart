import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:flappy_bird/overlays/fps.dart';

class FlappyBirdGame extends FlameGame with HasKeyboardHandlerComponents, HasCollisionDetection {

  bool isPaused = true;

  FlappyBirdGame({super.camera, super.world});

  @override
  Future<void> onLoad() async {
    await super.onLoad();
    await add(FrameRateOverlay());
  }

  @override
  void update(double dt) {
    if (isPaused) return;
    super.update(dt);
  }

  void pauseGame() {
    isPaused = true;
    if (overlays.isActive('pause')) return;
    overlays.add('pause');
  }

  void resumeGame() {
    isPaused = false;
    if (overlays.isActive('pause')) {
      overlays.remove('pause');
    }
  }

  void togglePause() {
    if (isPaused) {
      resumeGame();
    } else {
      pauseGame();
    }
  }

  void restartGame() {
    isPaused = false;
    if (overlays.isActive('pause')) {
      overlays.remove('pause');
    }
    removeAll(children);
    onLoad();
  }

}
