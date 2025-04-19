import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flappy_bird/game.dart';
import 'package:flappy_bird/world/objects/pipeline.dart';
import 'package:flutter/services.dart';


class Bird extends SpriteAnimationComponent with
    HasGameRef<FlappyBirdGame>,
    KeyboardHandler,
    CollisionCallbacks,
    TapCallbacks {

  final double _gravity = 1000;
  final double _jumpVelocity = -300;
  final double _maxFallSpeed =  500;
  double _velocityY = 0;
  bool _isDead = false;

  bool get isDead => _isDead;

  @override
  Future<void> onLoad() async {
    await super.onLoad();

    // debugMode = true;
    // debugColor = Colors.transparent;

    final worldSize = gameRef.size;

    position = Vector2(-(worldSize.x / 3), 0);
    angle = -.2;
    priority = 1;
    size = Vector2(50, 50);
    anchor = Anchor.center;
    animation = await SpriteAnimation.load(
      'flutter-bird-mascot-sprite.png',
      SpriteAnimationData.sequenced(
        amount: 3,
        stepTime: .1,
        textureSize: Vector2.all(341.33),
        texturePosition: Vector2(0, 350),
      ),
    );

    add(
        CircleHitbox(
          radius: 25,
          position: Vector2(0, 0),
      ),
    );

  }

  @override
  void update(double dt) {
    super.update(dt);

    if (_isDead || game.isPaused) {
      return;
    }

    _velocityY += _gravity * dt;

    if (_velocityY > _maxFallSpeed) {
      _velocityY = _maxFallSpeed;
    }

    position.y += _velocityY * dt;

    angle = _velocityY / 500;

    if (position.y > gameRef.size.y) {
      _isDead = true;
    }
  }

  @override
  bool onKeyEvent(KeyEvent event, Set<LogicalKeyboardKey> keysPressed)  {
    if (event is KeyDownEvent && keysPressed.contains(LogicalKeyboardKey.space)) {
        jump();
    }
    return true;
  }

  @override
  void onCollisionStart(Set<Vector2> intersectionPoints, PositionComponent other) {
    super.onCollisionStart(intersectionPoints, other);
    if (game.isPaused) {
      return;
    }
    if (other is Pipe || other is ScreenHitbox) {
      _isDead = true;
      _velocityY = 0;
      game
        ..pause()
        ..overlays.add('restart');
    }
    else if (other is ScoreCheck) {
      game.incrementScore();
    }
  }

  void jump() {
    if (!_isDead) {
      _velocityY = _jumpVelocity;
    }
  }

}
