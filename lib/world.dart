import 'package:flame/components.dart';
import 'package:flappy_bird/bird.dart';
import 'package:flappy_bird/pipe.dart';

class MyWorld extends World {

  final pipes = <Pipe>[];

  @override
  Future<void> onLoad() async {
    await super.onLoad();
    await add(Bird());
    await add(PipePairComponent());
  }


}