import 'dart:ui';

import 'package:flame/sprite.dart';

import '../game.dart';

class StartButton {
  static const imagePath = 'ui/start-button.png';
  static const tileCols = 6;
  static const tileRows = 3;

  final FlySwatterGame game;

  Rect _rect;
  Sprite _sprite;

  StartButton(this.game) {
    final margin = game.tileSize * 1.5;

    _rect = Rect.fromLTWH(
      margin,
      (game.screenSize.height * .75) - margin,
      game.tileSize * tileCols,
      game.tileSize * tileRows,
    );

    _sprite = Sprite(imagePath);
  }

  void update(double dt) {

  }

  void render(Canvas canvas) {
    _sprite.renderRect(canvas, _rect);
  }

  bool hitTest(Offset offset) => _rect.contains(offset);
}