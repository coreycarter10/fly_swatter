import 'dart:ui';

import 'package:flame/sprite.dart';

import '../game.dart';

class Backyard {
  static const imagePath = 'bg/backyard.png';

  final FlySwatterGame game;
  final Sprite sprite = Sprite(imagePath);

  Rect _rect;

  Backyard(this.game) {
    final verticalSize = game.tileSize * FlySwatterGame.tileRows;

    _rect = Rect.fromLTWH(
      0,
      game.screenSize.height - verticalSize,
      game.screenSize.width,
      verticalSize,
    );
  }

  void update(double dt) {

  }

  void render(Canvas canvas) {
    sprite.renderRect(canvas, _rect);
  }
}
