import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flame/util.dart';
import 'package:flame/game.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final flameUtil = Util();
  await flameUtil.fullScreen();
  await flameUtil.setOrientations([DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);

  final game = FlySwatterGame();
  final tapper = TapGestureRecognizer()..onTapDown = game.onTapDown;
  flameUtil.addGestureRecognizer(tapper);
  runApp(game.widget);
}

class FlySwatterGame extends Game {
  Size _screenSize;

  GameBox _bg;
  GameBox _target;

  @override
  void resize(Size size) {
    if (_screenSize != null) {
      return;
    }

    _screenSize = size;

    initGameObjects();
  }

  void initGameObjects() {
    _bg = GameBox(
      x: 0,
      y: 0,
      w: _screenSize.width,
      h: _screenSize.height,
      color: Colors.black,
    );

    final targetSize = 150.0;
    final halfTargetSize = targetSize / 2;
    _target = GameBox(
      x: (_screenSize.width / 2) - halfTargetSize,
      y: (_screenSize.height / 2) - halfTargetSize,
      w: targetSize,
      h: targetSize,
      color: Colors.white,
    );
  }

  @override
  void update(double dt) {

  }

  @override
  void render(Canvas canvas) {
    _bg.render(canvas);
    _target.render(canvas);
  }

  void onTapDown(TapDownDetails details) {
    if (_target.hitTest(details.globalPosition)) {
      _target.setColor(Colors.green);
    }
  }
}

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
}