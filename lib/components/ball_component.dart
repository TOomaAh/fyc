import 'dart:math';
import 'dart:ui';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/particles.dart';
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

  void _showParticules({
    double angle = 0,
  }) {
    Random rnd = Random();

    Vector2 randomVector2() =>
        (Vector2.random(rnd) - Vector2.random(rnd)) * 200;
    gameRef.add(
      ParticleSystemComponent(
        angle: angle,
        position: position,
        particle: Particle.generate(
          count: 50,
          generator: (i) => AcceleratedParticle(
            speed:
                Vector2(rnd.nextDouble() * 200 - 100, -rnd.nextDouble() * 100),
            child: CircleParticle(
              radius: 2.0,
              paint: Paint()..color = Colors.white,
            ),
          ),
        ),
      ),
    );
  }

  @override
  void onCollision(Set<Vector2> intersectionPoints, PositionComponent other) {
    super.onCollision(intersectionPoints, other);
    final collisionPoint = intersectionPoints.first;
    if (other is ScreenHitbox) {
      if (collisionPoint.x == 0) {
        velocity.x = -velocity.x;
      } else if (collisionPoint.x == gameRef.size.x) {
        // Right Side Collision
        velocity.x = -velocity.x;
      } else if (collisionPoint.y == 0) {
        // Top Side Collision
        velocity.y = -velocity.y;
        _showParticules(angle: 180);
      } else if (collisionPoint.y == gameRef.size.y) {
        // Bottom Side Collision
        velocity.y = -velocity.y;
        _showParticules();
      }
    }
  }
}
