import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';

import 'ball_component.dart';

class BarComponent extends PositionComponent
    with CollisionCallbacks, KeyboardHandler {
  BarComponent({
    required Vector2 position,
    required Vector2 size,
    required Color color,
  }) {
    this.position = position;
    this.size = size;
    _paint = Paint()..color = color;
  }

  late final Paint _paint;
  late final RectangleHitbox paddleHitBox;
  late final RectangleComponent paddle;

  @override
  Future<void>? onLoad() async {
    paddle = RectangleComponent(
      size: size,
      paint: _paint,
    );
    paddleHitBox = RectangleHitbox(
      size: size,
    );
    addAll([
      paddle,
      paddleHitBox,
    ]);
  }

  @override
  bool onKeyEvent(RawKeyEvent event, Set<LogicalKeyboardKey> keysPressed) {
    if (event is RawKeyDownEvent) {
      if (keysPressed.contains(LogicalKeyboardKey.arrowLeft)) {
        position.x -= 50;
      } else if (keysPressed.contains(LogicalKeyboardKey.arrowRight)) {
        position.x += 50;
      }
    }
    return super.onKeyEvent(event, keysPressed);
  }

  @override
  void onCollision(Set<Vector2> intersectionPoints, PositionComponent other) {
    // TODO: implement onCollision
    super.onCollision(intersectionPoints, other);
    if (other is BallComponent) {
      BallComponent ball = other;
      other.velocity.y *= -1;
    }
  }
}
