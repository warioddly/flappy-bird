import 'package:flappy_bird/game.dart';
import 'package:flutter/material.dart';

class MenuOverlay extends StatelessWidget {
  const MenuOverlay({super.key, required this.game});

  final FlappyBirdGame game;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black54,
      child: Center(
        child: ElevatedButton(
          onPressed: () {
            if (game.overlays.isActive('menu')) {
              game.overlays.remove('menu');
            }
            game.resume();
          },
          child: const Text('Start'),
        ),
      ),
    );
  }
}

