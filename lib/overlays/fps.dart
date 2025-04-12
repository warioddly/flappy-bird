

import 'package:flame/components.dart';

class FrameRateOverlay extends PositionComponent {

  @override
  Future<void> onLoad() async {
    await super.onLoad();
    await add(FpsComponent());
  }

}