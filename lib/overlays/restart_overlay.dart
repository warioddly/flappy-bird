


import 'package:flappy_bird/game.dart';
import 'package:flutter/material.dart';

class RestartOverlay extends StatelessWidget {
  const RestartOverlay({super.key, required this.game});

  final FlappyBirdGame game;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black54,
      child: Center(
        child: ElevatedButton(
          onPressed: () {
            game.restartGame();
          },
          child: const Text('Restart'),
        ),
      ),
    );
  }
}

