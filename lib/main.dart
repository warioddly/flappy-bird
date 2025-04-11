import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flappy_bird/world.dart';
import 'package:flutter/material.dart';

import 'game.dart';

void main() {
  runApp(
    MaterialApp(
      home: Builder(
        builder: (context) {
          final size = MediaQuery.sizeOf(context);
          return GameWidget(
            game: FlappyBirdGame(
              world: MyWorld(),
              camera: CameraComponent.withFixedResolution(
                width: size.width,
                height: size.height,
              ),
            ),
          );
        },
      )
    ),
  );
}

