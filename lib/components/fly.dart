import 'dart:ui';

import 'package:flutter/material.dart';

import '../game.dart';
import 'game_rect.dart';

class Fly extends GameRect {
  static const fallSpeed = 12;

  final FlySwatterGame game;

  FlyStatus _status = FlyStatus.alive;
  FlyStatus get status => _status;

  Fly({
    @required this.game,
    @required double x,
    @required double y,
    @required double w,
    @required double h,
    Color color,
  }) : super(x: x, y: y, w: w, h: h, color: color ?? Colors.green[100]);

  void update(double dt) {
    switch (_status) {
      case FlyStatus.alive: _fly(dt); break;
      case FlyStatus.dead: _fall(dt); break;
      default: break;
    }
  }

  void kill() {
    setColor(Colors.red);
    _status = FlyStatus.dead;
  }

  void _fly(double dt) {

  }

  void _fall(double dt) {
    translate(0, h * fallSpeed * dt);

    // is the fly off-screen?
    if (isOffScreen(game.screenSize)) {
      game.removeFly(this);
    }
  }
}

enum FlyStatus {
  alive,
  dead,
}