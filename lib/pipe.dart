

import 'dart:math';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flappy_bird/game.dart';
import 'package:flutter/material.dart';

const double pipeWidth = 50;
const double pipeHeight = 350;
const double pipePairsGap = 300.0;
const double _pipesSpeed = 2.0;

class Pipe extends PositionComponent {

  @override
  Future<void> onLoad() async {
    await super.onLoad();

    debugColor = Colors.transparent;
    debugMode = true;

    size = Vector2(pipeWidth, pipeHeight);

    priority = 1;

    add(
      RectangleHitbox(
        size: Vector2(pipeWidth, pipeHeight),
        position: position,
        collisionType: CollisionType.passive,
      ),
    );
  }

}

class PipeTop extends Pipe {
  @override
  Future<void> onLoad() async {
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

class PipeBottom extends Pipe {
  @override
  Future<void> onLoad() async {
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

class Pipes extends PositionComponent {

  @override
  Future<void> onLoad() async {
    await super.onLoad();

    await addAll([
      PipeTop()..position = Vector2(0, -220),
      PipeBottom()..position = Vector2(0, 50),
    ]);

  }

}

class PipePairComponent extends PositionComponent with HasGameRef<FlappyBirdGame>{

  final _pipes = <Pipes>[];
  final random = Random();

  @override
  Future<void> onLoad() async {
    await super.onLoad();

    final possiblePipesCount = gameRef.size.x ~/ pipePairsGap + 6;

    final pipes = List.generate(possiblePipesCount, (int index) {
      return Pipes()
        ..position = Vector2(pipePairsGap * index, random.nextInt(300) - 150);
    });

    _pipes.addAll(pipes);

    await addAll(_pipes);
  }

  @override
  void update(double dt) {
    super.update(dt);

    for (final pipePair in _pipes) {

      pipePair.position.x -= 100 * _pipesSpeed * dt;

      if (pipePair.position.x  <= -((gameRef.size.x / 2) + pipePairsGap + pipeWidth)) {

        pipePair.position
          ..x = _pipes[_pipes.length - 1].position.x + pipePairsGap
          ..y =  random.nextInt(300) - 150;

        _pipes
          ..remove(pipePair)
          ..add(pipePair);

      }

    }

  }

}


