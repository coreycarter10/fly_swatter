import 'dart:ui';

import 'package:flame/sprite.dart';
import 'package:flutter/material.dart';

import '../game.dart';

class HelpButton {
  static const imagePath = 'ui/icon-help.png';

  final FlySwatterGame game;

  Rect _rect;
  Sprite _sprite;

  HelpButton(this.game) {
    final margin = game.tileSize * 1.25;

    _rect = Rect.fromLTWH(
      game.screenSize.width - margin,
      game.screenSize.height - margin,
      game.tileSize,
      game.tileSize,
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