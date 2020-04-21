import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flame/game.dart';

import 'main.dart';
import 'components/backyard.dart';
import 'components/fly.dart';

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
    final y = random.nextDouble() * (_screenSize.height - _tileSize);
    _flies.add(Fly(game: this, x: 0, y: y, w: tileSize, h: tileSize));
  }

  void onTapDown(TapDownDetails details) {
    _flies.forEach((Fly fly) {
      if (fly.status == FlyStatus.alive && fly.hitTest(details.globalPosition)) {
        fly.kill();
        scheduleMicrotask(_spawnFly);
      }
    });
  }

  void removeFly(Fly fly) => scheduleMicrotask(() => _flies.remove(fly));
}
