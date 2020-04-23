import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flame/sprite.dart';

import 'flies.dart';

class Callout {
  static const imagePath = 'ui/callout.png';

  static const style = TextStyle(
    color: Colors.black,
    fontSize: 25,
  );

  final Fly fly;

  Rect _rect;
  Sprite _sprite = Sprite(imagePath);

  double _value = 1;

  Offset _textPos;

  final painter = TextPainter(
    textAlign: TextAlign.center,
    textDirection: TextDirection.ltr,
  );

  Callout(this.fly);

  void update(double dt) {
    _value -= .5 * dt;

    if (_value <= 0) {
      fly.game.lost();
    }

    final size = fly.game.tileSize * .75;

    _rect = Rect.fromLTWH(
      fly.hitX - (fly.game.tileSize * .25),
      fly.hitY - (fly.game.tileSize * .5),
      size,
      size,
    );

    painter.text = TextSpan(
      text: (_value * 10).toInt().toString(),
      style: style,
    );

    painter.layout();

    _textPos = Offset(
      _rect.center.dx - (painter.width / 2),
      _rect.top + (_rect.height * .4) - (painter.height / 2),
    );
  }

  void render(Canvas canvas) {
    _sprite.renderRect(canvas, _rect);
    painter.paint(canvas, _textPos);
  }
}