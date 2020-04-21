import 'dart:async';
import 'dart:math';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flame/util.dart';
import 'package:flame/flame.dart';
import 'package:flame/game.dart';

import 'components/game_box.dart';
import 'components/fly.dart';

final flameUtil = Util();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await flameUtil.fullScreen();
  await flameUtil.setOrientations([DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);

  final game = FlySwatterGame();
  final tapper = TapGestureRecognizer()..onTapDown = game.onTapDown;
  flameUtil.addGestureRecognizer(tapper);

  await Flame.images.loadAll(<String>[
    'bg/backyard.png',
    'flies/agile-fly-1.png',
    'flies/agile-fly-2.png',
    'flies/agile-fly-dead.png',
    'flies/drooler-fly-1.png',
    'flies/drooler-fly-2.png',
    'flies/drooler-fly-dead.png',
    'flies/house-fly-1.png',
    'flies/house-fly-2.png',
    'flies/house-fly-dead.png',
    'flies/hungry-fly-1.png',
    'flies/hungry-fly-2.png',
    'flies/hungry-fly-dead.png',
    'flies/macho-fly-1.png',
    'flies/macho-fly-2.png',
    'flies/macho-fly-dead.png',
  ]);

  runApp(game.widget);
}

class FlySwatterGame extends Game {
  static final random = Random();

  Size _screenSize;
  Size get screenSize => _screenSize;

  double _tileSize;
  double get tileSize => _tileSize;

  GameBox _bg;
  List<Fly> _flies;

  FlySwatterGame() {
    _init();
  }

  void _init() async {
    resize(await flameUtil.initialDimensions());

    _bg = GameBox(
      x: 0,
      y: 0,
      w: _screenSize.width,
      h: _screenSize.height,
      color: Colors.black,
    );

    _flies = [];

    _spawnFly();
  }


  @override
  void resize(Size size) {
    _screenSize = size;
    _tileSize = _screenSize.width / 9;
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
    _flies.add(Fly(game: this, x: 0, y: y));
  }

  void onTapDown(TapDownDetails details) {
    _flies.forEach((Fly fly) {
      if (fly.hitTest(details.globalPosition)) {
        fly.kill();
        scheduleMicrotask(_spawnFly);
      }
    });
  }

  void removeFly(Fly fly) => scheduleMicrotask(() => _flies.remove(fly));
}
