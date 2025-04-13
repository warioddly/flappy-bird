import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flappy_bird/game.dart';
import 'package:flappy_bird/world/objects/pipe.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';


class Bird extends SpriteAnimationComponent with
    HasGameRef<FlappyBirdGame>,
    KeyboardHandler,
    CollisionCallbacks,
    TapCallbacks {

  double gravity = 1000;
  double jumpVelocity = -300;
  double velocityY = 0;
  double maxFallSpeed =  500;
  bool isDead = false;

  @override
  Future<void> onLoad() async {
    await super.onLoad();

    debugMode = true;
    debugColor = Colors.transparent;

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

    if (isDead) return;

    velocityY += gravity * dt;

    if (velocityY > maxFallSpeed) {
      velocityY = maxFallSpeed;
    }

    position.y += velocityY * dt;

    angle = velocityY / 500;

    if (position.y > gameRef.size.y) {
      isDead = true;
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
  void onCollisionStart(
      Set<Vector2> intersectionPoints,
      PositionComponent other,
  ) {
    super.onCollisionStart(intersectionPoints, other);
    if (other is Pipe || other is ScreenHitbox) {
      isDead = true;
      velocityY = 0;
      game.restartGame();
    }
  }

  void jump() {
    if (!isDead) {
      velocityY = jumpVelocity;
    }
  }

}
