


import 'package:flappy_bird/game.dart';
import 'package:flutter/material.dart';

class RestartOverlay extends StatelessWidget {
  const RestartOverlay({super.key, required this.game});

  final FlappyBirdGame game;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Container(
        color: Colors.black54,
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [

              Text(
                'Game Over',
                style: const TextStyle(
                  fontSize: 40,
                  color: Colors.white,
                ),
              ),

              const SizedBox(height: 20),

              Text(
                'Score: ${game.score}',
                style: const TextStyle(
                  fontSize: 22,
                  color: Colors.white,
                ),
              ),

              const SizedBox(height: 16),

              IconButton(
                onPressed: game.restart,
                icon: const Icon(
                  Icons.refresh,
                  color: Colors.white,
                  size: 40,
                ),
              ),

              Text(
                'Restart',
                style: const TextStyle(
                  fontSize: 16,
                  color: Colors.white,
                ),
              ),

            ],
          ),
        )
      ),
    );
  }
}

