import 'package:flappy_bird/game.dart';
import 'package:flutter/material.dart';

class PauseOverlay extends StatelessWidget {
  const PauseOverlay({super.key, required this.game});

  final FlappyBirdGame game;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black54,
      child: Center(
        child: ElevatedButton(
          onPressed: () {
            game.resume();
          },
          child: const Text('Resume'),
        ),
      ),
    );
  }
}

