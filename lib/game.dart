import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/game.dart';

class FlappyBirdGame extends FlameGame with HasKeyboardHandlerComponents, HasCollisionDetection {

  FlappyBirdGame({
    super.camera,
    super.world,
  }) {
  }

  @override
  Future<void> onLoad() async {
    await super.onLoad();
    await add(
      PositionComponent(
        position: Vector2(30, 110),
        size: Vector2(100, 100),
        children: [FpsComponent()],
      ),
    );
  }

}