import 'package:flutter/services.dart';

abstract class BarMovement {
  LogicalKeyboardKey left();
  LogicalKeyboardKey right();
  LogicalKeyboardKey up();
  LogicalKeyboardKey down();
}

class PlayerMovement implements BarMovement {
  @override
  LogicalKeyboardKey down() {
    return LogicalKeyboardKey.arrowDown;
  }

  @override
  LogicalKeyboardKey left() {
    // TODO: implement left
    return LogicalKeyboardKey.arrowLeft;
  }

  @override
  LogicalKeyboardKey right() {
    // TODO: implement right
    return LogicalKeyboardKey.arrowRight;
  }

  @override
  LogicalKeyboardKey up() {
    // TODO: implement up
    return LogicalKeyboardKey.arrowUp;
  }
}

class OtherPlayerMovement implements BarMovement {
  @override
  LogicalKeyboardKey down() {
    return LogicalKeyboardKey.keyS;
  }

  @override
  LogicalKeyboardKey left() {
    return LogicalKeyboardKey.keyQ;
  }

  @override
  LogicalKeyboardKey right() {
    return LogicalKeyboardKey.keyD;
  }

  @override
  LogicalKeyboardKey up() {
    return LogicalKeyboardKey.keyZ;
  }
}
