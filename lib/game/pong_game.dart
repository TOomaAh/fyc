import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/flame.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:pong/components/ball_component.dart';
import 'package:pong/components/bar_component.dart';

class PongGame extends FlameGame
    with HasCollisionDetection, HasKeyboardHandlerComponents, HasTappables {
  @override
  Future<void>? onLoad() async {
    await Flame.device.fullScreen();
    await Flame.device.setPortrait();
    await addAll([
      ScreenHitbox(),
      BarComponent(
        position: Vector2(size.x / 2 - 50, size.y * 0.90),
        size: Vector2(100, 10),
        color: Colors.white,
      ),
      BallComponent(),
    ]);

    return super.onLoad();
  }
}
