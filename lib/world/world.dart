import 'package:flame/components.dart';
import 'package:flappy_bird/game.dart';
import 'package:flappy_bird/world/characters/bird.dart';
import 'package:flappy_bird/world/objects/ground.dart';
import 'package:flappy_bird/world/objects/pipe.dart';
import 'package:flutter/services.dart';

class MyWorld extends World with HasGameRef<FlappyBirdGame>, KeyboardHandler {

  late Bird _bird;

  Bird get bird => _bird;

  @override
  Future<void> onLoad() async {
    await super.onLoad();
    await addAll([
      _bird = Bird(),
      PipePairComponent(),
      Ground(),
      ScreenHitbox()..debugMode = true
    ]);
  }

  @override
  bool onKeyEvent(KeyEvent event, Set<LogicalKeyboardKey> keysPressed)  {
    if (event is KeyDownEvent && keysPressed.contains(LogicalKeyboardKey.escape)) {
      game.togglePause();
    }
    return true;
  }

}