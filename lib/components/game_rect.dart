import 'package:flutter/material.dart';

class GameRect {
  Paint _paint;
  Rect _rect;

  GameRect({
      @required double x,
      @required double y,
      @required double w,
      @required double h,
      @required Color color}) {
    _paint = Paint()..color = color;
    _rect = Rect.fromLTWH(x, y, w, h);
  }

  void render(Canvas canvas) {
    canvas.drawRect(_rect, _paint);
  }

  void setColor(Color color) => _paint.color = color;

  bool hitTest(Offset offset) => _rect.contains(offset);

  bool isOffScreen(Size screenSize) => x < 0 || x > screenSize.width || y < 0 || y > screenSize.height;

  void translate(double x, double y) {
    _rect = _rect.translate(x, y);
  }

  double get x => _rect.left;
  double get y => _rect.top;
  double get w => _rect.width;
  double get h => _rect.height;
}
