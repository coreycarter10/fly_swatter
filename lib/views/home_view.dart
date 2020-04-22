import 'dart:ui';

import 'package:flutter/gestures.dart';

import '../game.dart';
import '../components/title.dart';
import '../components/start_button.dart';

class HomeView {
  final FlySwatterGame game;

  Title _title;
  StartButton _startButton;

  HomeView(this.game) {
    _title = Title(game);
    _startButton = StartButton(game);
  }

  void update(double dt) {

  }

  void render(Canvas canvas) {
    _title.render(canvas);
    _startButton.render(canvas);
  }

  void onTapDown(TapDownDetails details) {
    if (_startButton.hitTest(details.globalPosition)) {
      game.startGame();
    }
  }
}