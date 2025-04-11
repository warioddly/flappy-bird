
import 'package:flame/components.dart';
import 'package:flappy_bird/game.dart';
import 'package:flutter/services.dart';


class Bird extends SpriteAnimationComponent with HasGameRef<FlappyBirdGame>, KeyboardHandler {

  double gravity = 1000;
  double jumpVelocity = -300;
  double velocityY = 0;
  double maxFallSpeed =  500;
  bool isDead = false;

  @override
  Future<void> onLoad() async {
    await super.onLoad();
    final worldSize = gameRef.size;

    position = Vector2(-(worldSize.x / 3), 0);
    angle = -.2;
    size = Vector2(50, 150);
    anchor = Anchor.center;
    animation = await SpriteAnimation.load(
      'flutter-bird-mascot-sprite.png',
      SpriteAnimationData.sequenced(
        amount: 3,
        stepTime: 0.1,
        textureSize: Vector2(341.33, 1024),
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
      position.y = gameRef.size.y;
      velocityY = 0;
    }
  }

  @override
  bool onKeyEvent(KeyEvent event, Set<LogicalKeyboardKey> keysPressed) {
    if (event is KeyDownEvent && keysPressed.contains(LogicalKeyboardKey.space)) {
        jump();
    }
    return true;
  }

  void jump() {
    if (!isDead) {
      velocityY = jumpVelocity;
    }
  }

}
