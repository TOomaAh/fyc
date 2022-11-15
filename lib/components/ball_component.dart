import 'dart:ui';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import 'package:pong/game/pong_game.dart';

import 'dart:math' as math;

class BallComponent extends CircleComponent
    with CollisionCallbacks, KeyboardHandler, HasGameRef<PongGame> {
  BallComponent() {
    paint = Paint()..color = Colors.white;
    radius = 10.0;
  }

  static const degree = math.pi / 180;

  double _speed = 500.0;

  late Vector2 velocity;

  @override
  Future<void>? onLoad() async {
    _resetBall();

    final hitBox = CircleHitbox(
      radius: radius,
    );

    addAll([
      hitBox,
    ]);
    return super.onLoad();
  }

  void _resetBall() {
    position = gameRef.size / 2;
    final spawnAngle = getSpawnAngle;

    final vx = math.cos(spawnAngle * degree) * _speed;
    final vy = math.sin(spawnAngle * degree) * _speed;
    velocity = Vector2(
      vx,
      vy,
    );
  }

  @override
  void update(double dt) {
    super.update(dt);
    position += velocity * dt;
  }

  double get getSpawnAngle {
    final sideToThrow = math.Random().nextBool();

    final random = math.Random().nextDouble();
    final spawnAngle = sideToThrow
        ? lerpDouble(55, 125, random)!
        : lerpDouble(-55, -125, random)!;

    return spawnAngle;
  }

  @override
  void onCollision(Set<Vector2> intersectionPoints, PositionComponent other) {
    super.onCollision(intersectionPoints, other);
    final collisionPoint = intersectionPoints.first;
    if (other is ScreenHitbox) {
      if (collisionPoint.x == 0) {
        if (velocity.x < 0) {
          velocity.x = velocity.x * -1;
        }
        velocity.y = velocity.y;
        // TODO: play the collision sound
      } else if (collisionPoint.x == gameRef.size.x) {
        // Right Side Collision
        if (velocity.x > 0) {
          velocity.x = velocity.x * -1;
        }
        velocity.y = velocity.y;
        // TODO: play the collision sound
      } else if (collisionPoint.y == 0) {
        // Top Side Collision
        velocity.x = velocity.x;
        if (velocity.y < 0) {
          velocity.y = velocity.y * -1;
        }
      } else if (collisionPoint.y == gameRef.size.y) {
        // Bottom Side Collision
        velocity.x = velocity.x;
        if (velocity.y > 0) {
          velocity.y = velocity.y * -1;
        }
      }
    }
  }
}
