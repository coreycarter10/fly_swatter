import 'dart:ui';

import 'package:flutter/gestures.dart';

import '../game.dart';
import '../components/lose.dart';
import '../components/start_button.dart';
import '../components/help_button.dart';

class LostView {
  final FlySwatterGame game;

  Lose _lose;
  StartButton _startButton;
  HelpButton _helpButton;

  LostView(this.game) {
    _lose = Lose(game);
    _startButton = StartButton(game);
    _helpButton = HelpButton(game);
  }

  void update(double dt) {

  }

  void render(Canvas canvas) {
    _lose.render(canvas);
    _startButton.render(canvas);
    _helpButton.render(canvas);
  }

  void onTapDown(TapDownDetails details) {
    if (_startButton.hitTest(details.globalPosition)) {
      game.play();
    }
    else if (_helpButton.hitTest(details.globalPosition)) {
      game.help();
    }
  }
}