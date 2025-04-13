import 'dart:math';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flappy_bird/game.dart';
import 'package:flutter/material.dart';

const double _pipesSpeed = 2.0;
const double _pipeWidth = 60.0;
const double _pipesXGap = 300.0;
const double _pipesYGap = 70.0;
const double _pipeYPositionRandomize = 100.0;

class Pipe extends PositionComponent with HasGameRef<FlappyBirdGame> {

  Pipe({
    super.position,
    super.size,
    super.anchor,
    this.isTop = false,
  });

  final bool isTop;

  static const double _capHeight = 50;

  static const double _borderWidth = 4.0;

  Rect _bodyRect = Rect.zero;

  Rect _capRect = Rect.zero;

  final _paint = Paint()
    ..color = Colors.green
    ..style = PaintingStyle.fill;

  final _borderPaint = Paint()
    ..color = Colors.black54
    ..strokeWidth = _borderWidth
    ..style = PaintingStyle.stroke;


  @override
  Future<void> onLoad() async {
    await super.onLoad();

    final worldSize = gameRef.canvasSize;

    size = Vector2(_pipeWidth, worldSize.y);

    final bodyHeight = size.y - _capHeight;

    if (isTop) {
      _capRect = Rect.fromLTWH(0, size.y - _capHeight, size.x, _capHeight);
      _bodyRect = Rect.fromLTWH(
        _borderWidth,
        0,
        size.x - _borderWidth * 2,
        bodyHeight,
      );
    }
    else {
      _capRect = Rect.fromLTWH(0, 0, size.x, _capHeight);
      _bodyRect = Rect.fromLTWH(
        _borderWidth,
        _capHeight,
        size.x - _borderWidth * 2,
        bodyHeight - _borderWidth,
      );
    }

    add(
      RectangleHitbox(
        collisionType: CollisionType.passive,
        isSolid: true,
      )
        // ..debugColor = Colors.greenAccent
        // ..debugMode = true
    );

    // angle = isTop ? pi : 0;

  }

  @override
  void render(Canvas canvas) {
    super.render(canvas);

    _paint.shader = LinearGradient(
      colors: [
        Colors.lightGreen.shade300,
        Colors.green.shade600,
        Colors.lightGreen.shade300,
      ],
      stops: const [0.0, 0.5, 1.0],
      begin: Alignment.centerLeft,
      end: Alignment.centerRight,
    ).createShader(_bodyRect);
    canvas.drawRect(_bodyRect, _paint);

    _paint.shader = LinearGradient(
      colors: [
        Colors.lightGreen.shade200,
        Colors.green.shade700,
        Colors.lightGreen.shade200,
      ],
      stops: const [0.0, 0.5, 1.0],
      begin: Alignment.centerLeft,
      end: Alignment.centerRight,
    ).createShader(_capRect);

    canvas
      ..drawRect(_capRect, _paint)
      ..drawRect(_capRect, _borderPaint)
      ..drawRect(_bodyRect, _borderPaint);
  }

}

class Pipes extends PositionComponent with HasGameRef<FlappyBirdGame> {

  @override
  Future<void> onLoad() async {
    await super.onLoad();

    await addAll([
      Pipe(
        size: Vector2(_pipeWidth, -10),
        position: Vector2(0, -_pipesYGap),
        anchor: Anchor.bottomCenter,
        isTop: true,
      ),
      Pipe(
        size: Vector2(_pipeWidth, 10),
        position: Vector2(0, _pipesYGap),
        anchor: Anchor.topCenter,
      ),
      ScoreCheck()
    ]);

  }

}

class ScoreCheck extends PositionComponent with HasGameRef<FlappyBirdGame> {

  @override
  Future<void> onLoad() async {
    await super.onLoad();

    size = Vector2(_pipeWidth, _pipesYGap * 2);
    position = Vector2.zero();
    anchor = Anchor.center;

    add(
      RectangleHitbox(
        collisionType: CollisionType.passive,
        isSolid: true,
      )
          // ..debugColor = Colors.blue
          // ..debugMode = true
     );

  }
}

class PipelineComponent extends PositionComponent with HasGameRef<FlappyBirdGame>{

  final _pipes = <Pipes>[];
  final random = Random();

  @override
  Future<void> onLoad() async {
    await super.onLoad();

    priority = 1;

    final possiblePipesCount = gameRef.canvasSize.x ~/ ((_pipesXGap + _pipeWidth) / 2) + 1;

    final pipes = List.generate(possiblePipesCount, (int index) {
      return Pipes()
        ..position = Vector2(
            _pipesXGap * index + 300,
            _randomizePipeVerticalPosition(),
        );
    });

    _pipes.addAll(pipes);

    await addAll(_pipes);
  }

  @override
  void update(double dt) {
    super.update(dt);

    if (game.isPaused) {
      return;
    }

    for (final pipePair in _pipes) {

      pipePair.position.x -= 100 * _pipesSpeed * dt;

      if (pipePair.position.x  <= -((gameRef.size.x / 2) + _pipesXGap + _pipeWidth)) {

        pipePair.position
          ..x = _pipes[_pipes.length - 1].position.x + _pipesXGap + _pipeWidth
          ..y = _randomizePipeVerticalPosition();

        _pipes
          ..remove(pipePair)
          ..add(pipePair);

      }

    }

  }

  double _randomizePipeVerticalPosition() {
    return random.nextInt(300) - _pipeYPositionRandomize;
  }

}


