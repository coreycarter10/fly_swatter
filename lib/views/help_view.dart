import 'dart:ui';

import 'package:flutter/gestures.dart';

import 'package:flame/sprite.dart';

import '../game.dart';

class HelpView {
  static const imagePath = 'ui/dialog-help.png';
  static const tileCols = 8;
  static const tileRows = 12;

  final FlySwatterGame game;

  Rect _rect;
  Sprite _sprite;

  HelpView(this.game) {
    _rect = Rect.fromLTWH(
      game.tileSize * .5,
      (game.screenSize.height / 2) - (game.tileSize * (tileRows / 2)),
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