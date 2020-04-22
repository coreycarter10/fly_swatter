import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flame/game.dart';

import 'main.dart';
import 'components/backyard.dart';
import 'components/flies.dart';

class FlySwatterGame extends Game {
  static const tileRows = 23;
  static const tileCols = 9;

  static final random = Random();

  Size _screenSize;
  Size get screenSize => _screenSize;

  double _tileSize;
  double get tileSize => _tileSize;

  Backyard _bg;
  List<Fly> _flies;

  FlySwatterGame() {
    _init();
  }

  void _init() async {
    resize(await flameUtil.initialDimensions());

    _bg = Backyard(this);

    _flies = [];

    _spawnFly();
  }

  @override
  void resize(Size size) {
    _screenSize = size;
    _tileSize = _screenSize.width / tileCols;
  }

  @override
  void update(double dt) {
    _flies.forEach((Fly fly) => fly.update(dt));
  }

  @override
  void render(Canvas canvas) {
    _bg.render(canvas);
    _flies.forEach((Fly fly) => fly.render(canvas));
  }

  void _spawnFly() {
    final y = random.nextDouble() * (_screenSize.height - _tileSize * 2);
    _flies.add(_getRandomFly(y: y));
  }

  Fly _getRandomFly({double x = 0, double y = 0}) {
    switch (random.nextInt(5)) {
      case 0: return HouseFly(game: this, x: x, y: y); break;
      case 1: return DroolerFly(game: this, x: x, y: y); break;
      case 2: return AgileFly(game: this, x: x, y: y); break;
      case 3: return MachoFly(game: this, x: x, y: y); break;
      case 4: return HungryFly(game: this, x: x, y: y); break;
    }

    return null;
  }

  void onTapDown(TapDownDetails details) {
    _flies.forEach((Fly fly) {
      if (fly.status == FlyStatus.flying && fly.hitTest(details.globalPosition)) {
        fly.kill();
        scheduleMicrotask(_spawnFly);
      }
    });
  }

  void removeFly(Fly fly) => scheduleMicrotask(() => _flies.remove(fly));
}
