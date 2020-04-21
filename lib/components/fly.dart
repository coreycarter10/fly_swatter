import 'dart:ui';

import 'package:flutter/material.dart';

import '../main.dart';
import 'game_box.dart';

class Fly {
  static const fallSpeed = 12;

  final FlySwatterGame game;

  FlyStatus _status;
  FlyStatus get status => _status;

  GameBox _box;

  Fly({this.game, double x, double y}) {
    _status = FlyStatus.alive;
    _box = GameBox(x: x, y: y, w: game.tileSize, h: game.tileSize, color: Colors.green[100]);
  }

  void update(double dt) {
    switch (_status) {
      case FlyStatus.alive: _fly(dt); break;
      case FlyStatus.dead: _fall(dt); break;
      default: break;
    }
  }

  void render(Canvas canvas) {
    _box.render(canvas);
  }

  bool hitTest(Offset offset) => _box.hitTest(offset);

  void kill() {
    _box.setColor(Colors.red);
    _status = FlyStatus.dead;
  }

  void _fly(double dt) {

  }

  void _fall(double dt) {
    _box.translate(0, game.tileSize * fallSpeed * dt);

    // is the fly off-screen?
    if (_box.y > game.screenSize.height) {
      game.removeFly(this);
    }
  }
}

enum FlyStatus {
  alive,
  dead,
}