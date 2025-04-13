import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flappy_bird/overlays/menu_overlay.dart';
import 'package:flappy_bird/overlays/pause_overlay.dart';
import 'package:flappy_bird/overlays/restart_overlay.dart';
import 'package:flutter/material.dart';

import 'game.dart';

void main() {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Builder(
        builder: (context) {
          final size = MediaQuery.sizeOf(context);
          return GameWidget<FlappyBirdGame>(
            game: FlappyBirdGame(
              camera: CameraComponent.withFixedResolution(
                width: size.width,
                height: size.height,
              ),
            ),
            initialActiveOverlays: ['menu'],
            overlayBuilderMap: {
              'menu': (_, game) => MenuOverlay(game: game),
              'pause': (_, game) => PauseOverlay(game: game),
              'restart': (_, game) => RestartOverlay(game: game),
            },
          );
        },
      )
    ),
  );
}

