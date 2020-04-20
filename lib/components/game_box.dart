import 'package:flutter/material.dart';

class GameBox {
  Paint _paint;
  Rect _rect;

  GameBox({double x, double y, double w, double h, Color color}) {
    _paint = Paint()..color = color;
    _rect = Rect.fromLTWH(x, y, w, h);
  }

  void render(Canvas canvas) {
    canvas.drawRect(_rect, _paint);
  }

  void setColor(Color color) => _paint.color = color;

  bool hitTest(Offset offset) => _rect.contains(offset);

  void translate(double x, double y) {
    _rect = _rect.translate(x, y);
  }

  double get x => _rect.left;
  double get y => _rect.top;
  double get w => _rect.width;
  double get h => _rect.height;
}