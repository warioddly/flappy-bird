import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flappy_bird/game.dart';
import 'package:flappy_bird/world/background/mountains_background.dart';
import 'package:flappy_bird/world/characters/bird.dart';
import 'package:flappy_bird/world/objects/ground.dart';
import 'package:flappy_bird/world/objects/pipeline.dart';

class MyWorld extends World with
    HasGameRef<FlappyBirdGame>,
    TapCallbacks {

  late Bird _bird;

  @override
  Future<void> onLoad() async {
    await super.onLoad();

    await addAll([
      _bird = Bird(),
      PipelineComponent(),
      Ground(),
      ScreenHitbox(),
      MountainsBackground(),
    ]);

  }

  @override
  void onTapDown(TapDownEvent event) {
    super.onTapDown(event);
    _bird.jump();
  }

}
