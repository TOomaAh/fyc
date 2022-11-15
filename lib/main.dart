import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:pong/game/pong_game.dart';

void main() {
  runApp(const MyGame());
}

class MyGame extends StatelessWidget {
  const MyGame({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
      home: GameWidget<PongGame>(
        game: PongGame(),
      ),
    );
  }
}
