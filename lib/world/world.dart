import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flappy_bird/game.dart';
import 'package:flappy_bird/world/background/mountains_background.dart';
import 'package:flappy_bird/world/characters/bird.dart';
import 'package:flappy_bird/world/objects/ground.dart';
import 'package:flappy_bird/world/objects/pipeline.dart';
import 'package:flutter/services.dart';

class MyWorld extends World with
    HasGameRef<FlappyBirdGame>,
    KeyboardHandler,
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
  bool onKeyEvent(KeyEvent event, Set<LogicalKeyboardKey> keysPressed)  {
    if (event is KeyDownEvent && keysPressed.contains(LogicalKeyboardKey.escape)) {
      game.togglePause();
    }
    return true;
  }

  @override
  void onTapDown(TapDownEvent event) {
    super.onTapDown(event);
    _bird.jump();
  }

}
