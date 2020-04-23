import 'dart:ui';
import 'package:flutter/material.dart';

import '../game.dart';

class Score {
  static final painter = TextPainter(
    textAlign: TextAlign.center,
    textDirection: TextDirection.ltr,
  );

  static const style = TextStyle(
    color: Colors.white,
    fontSize: 90,
    shadows: <Shadow>[
      Shadow(
        blurRadius: 7,
        color: Colors.black,
        offset: Offset(3, 3),
      ),
    ],
  );

  final FlySwatterGame game;

  Offset _pos = Offset.zero;

  int _score;

  Score(this.game);

  void update(double dt) {
    if (game.score != _score) {
      _score = game.score;

      painter.text = TextSpan(
        text: _score.toString(),
        style: style,
      );

      painter.layout();

      _pos = Offset(
        game.centerX - (painter.width / 2),
        (game.screenSize.height * .10) - (painter.height / 2),
      );
    }
  }

  void render(Canvas canvas) {
    painter.paint(canvas, _pos);
  }
}