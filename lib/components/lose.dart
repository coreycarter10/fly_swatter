import 'dart:ui';

import 'package:flame/sprite.dart';

import '../game.dart';

class Lose {
  static const imagePath = 'bg/lose-splash.png';
  static const tileCols = 7;
  static const tileRows = 5;

  final FlySwatterGame game;

  Rect _rect;
  Sprite _sprite;

  Lose(this.game) {
    final height = game.tileSize * tileRows;

    _rect = Rect.fromLTWH(
      game.tileSize,
      (game.screenSize.height / 2) - (height),
      game.tileSize * tileCols,
      height,
    );

    _sprite = Sprite(imagePath);
  }

  void update(double dt) {

  }

  void render(Canvas canvas) {
    _sprite.renderRect(canvas, _rect);
  }
}