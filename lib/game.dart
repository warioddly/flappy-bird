import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:flappy_bird/overlays/fps.dart';
import 'package:flappy_bird/world/world.dart';

class FlappyBirdGame extends FlameGame with HasKeyboardHandlerComponents, HasCollisionDetection, TapDetector {

  bool isPaused = true;

  FlappyBirdGame({super.camera});

  @override
  Future<void> onLoad() async {
    await super.onLoad();
    await add(world = MyWorld());
    await add(FrameRateOverlay());
  }

  @override
  void update(double dt) {
    // if (isPaused) return;
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
    if (overlays.isActive('restart')) {
      overlays.remove('restart');
    }
    onLoad();
  }

  @override
  void onTap() {
    super.onTap();
    (world as MyWorld).bird.jump();
  }

}
