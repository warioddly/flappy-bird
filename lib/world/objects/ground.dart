import 'dart:async';

import 'package:flame/components.dart';
import 'package:flappy_bird/game.dart';
import 'package:flutter/material.dart';

class Ground extends PositionComponent with HasGameRef<FlappyBirdGame> {

   @override
  FutureOr<void> onLoad() async {

    final screenSize = game.canvasSize;

    position = Vector2(0, screenSize.y - 100);
    size = Vector2(screenSize.x, 100);
    anchor = Anchor.center;

    await super.onLoad();
  }

  @override
  void render(Canvas canvas) {
    super.render(canvas);
    canvas.drawRect(
      Rect.fromLTWH(position.x, position.y, size.x, size.y),
      Paint()..color = Colors.green,
    );
  }

}