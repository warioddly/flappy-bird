import 'package:flame/components.dart';
import 'package:flame/parallax.dart';

class MountainsBackground extends ParallaxComponent  {

  @override
  Future<void> onLoad() async {
    await super.onLoad();

    parallax = await Parallax.load(
      [
        ParallaxImageData('background/sky_lightened.png'),
        ParallaxImageData('background/sky.png'),
        ParallaxImageData('background/cloud_lonely.png'),
        ParallaxImageData('background/clouds_bg.png'),
        ParallaxImageData('background/clouds_mg_1_lightened.png'),
        ParallaxImageData('background/glacial_mountains_lightened.png'),
        ParallaxImageData('background/clouds_mg_3.png'),
        ParallaxImageData('background/glacial_mountains.png'),
        ParallaxImageData('background/clouds_mg_2.png'),
        ParallaxImageData('background/clouds_mg_1.png'),
      ],
      baseVelocity: Vector2(10, 0),
      velocityMultiplierDelta: Vector2(1.3, 0),
    );

    position = Vector2(0, 0);
    anchor = Anchor.center;
    isFullscreen = true;
    priority = 0;

  }

  @override
  void update(double dt) {
    if (game.paused) {
      return;
    }
    super.update(dt);
  }

}