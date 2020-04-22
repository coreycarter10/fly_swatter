import 'dart:ui';

import 'package:flame/sprite.dart';

import '../game.dart';

class Title {
  static const imagePath = 'branding/title.png';
  static const tileCols = 7;
  static const tileRows = 4;

  final FlySwatterGame game;

  Rect _rect;
  Sprite _sprite;

  Title(this.game) {
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