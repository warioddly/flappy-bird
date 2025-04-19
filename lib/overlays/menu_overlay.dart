import 'package:flappy_bird/game.dart';
import 'package:flutter/cupertino.dart' show CupertinoIcons;
import 'package:flutter/material.dart';

class MenuOverlay extends StatefulWidget {
  const MenuOverlay({super.key, required this.game});

  final FlappyBirdGame game;

  @override
  State<MenuOverlay> createState() => _MenuOverlayState();
}

class _MenuOverlayState extends State<MenuOverlay> {

  @override
  void initState() {
    super.initState();
     Future.delayed(Duration.zero, widget.game.pause);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/Flappy_Bird.png'),
          ),
          color: Color(0xFF4EC0CA)
        ),
        child: Align(
          alignment: Alignment(0.0, .75),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(
                onPressed: () {
                  if (widget.game.overlays.isActive('menu')) {
                    widget.game.overlays.remove('menu');
                  }
                  widget.game.resume();
                },
                icon: const Icon(
                  CupertinoIcons.play,
                  color: Colors.white,
                  size: 40,
                ),
              ),
              Text(
                'Play',
                style: const TextStyle(
                  fontSize: 16,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

