import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flame/game.dart';
import 'package:supercharged/supercharged.dart';

import 'main.dart';
import 'views/home_view.dart';
import 'views/lost_view.dart';
import 'views/help_view.dart';
import 'components/backyard.dart';
import 'components/flies.dart';

class FlySwatterGame extends Game {
  static const tileCols = 9;
  static const tileRows = 23;

  static const spawnInterval = Duration(milliseconds: 500);
  static const maxFlies = 7;

  static final random = Random();

  Size _screenSize;
  Size get screenSize => _screenSize;

  double _tileSize;
  double get tileSize => _tileSize;

  View _view;
  View _back;

  HomeView _homeView;
  LostView _lostView;
  HelpView _helpView;

  Backyard _bg;
  List<Fly> _flies;

  Timer _spawnTimer;

  FlySwatterGame() {
    _init();
  }

  void _init() async {
    resize(await flameUtil.initialDimensions());

    _homeView = HomeView(this);
    _lostView = LostView(this);
    _helpView = HelpView(this);

    _bg = Backyard(this);
    _flies = [];

    _home();
  }

  void play() {
    _view = View.playing;
    _flies.clear();
    _spawnTimer = Timer.periodic(spawnInterval, _spawnFly);
    _spawnFly();
  }

  void help() {
    _back = _view;
    _view = View.help;
  }

  void _home() {
    _view = View.home;
  }

  void _lost() {
    _view = View.lost;
    _spawnTimer.cancel();
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

    if (_view == View.home) {
      _homeView.render(canvas);
    }
    else if (_view == View.lost) {
      _lostView.render(canvas);
    }
    else if (_view == View.help) {
      _helpView.render(canvas);
    }
  }

  void _spawnFly([_]) {
    final liveFlies = _flies.count((Fly fly) => fly.status == FlyStatus.flying);

    if (liveFlies < maxFlies) {
      final y = random.nextDouble() * (_screenSize.height - _tileSize * 2);
      _flies.add(_getRandomFly(y: y));
    }
    else {
      _lost();
    }
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
    switch (_view) {
      case View.playing:
        bool gotKill = false;

        _flies.forEach((Fly fly) {
          if (fly.status == FlyStatus.flying && fly.hitTest(details.globalPosition)) {
            gotKill = true;
            fly.kill();
          }
        });

        if (!gotKill) {
          _lost();
        }
        break;
      case View.home:  _homeView.onTapDown(details); break;
      case View.lost:  _lostView.onTapDown(details); break;
      case View.help:  _back == View.home ? _home() : _lost(); break;
    }
  }

  void removeFly(Fly fly) => scheduleMicrotask(() => _flies.remove(fly));
}

enum View {
  home,
  playing,
  lost,
  help,
}