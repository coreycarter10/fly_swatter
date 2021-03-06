import 'dart:ui';

import 'package:flutter/gestures.dart';

import '../game.dart';
import '../components/title.dart';
import '../components/start_button.dart';
import '../components/help_button.dart';

class HomeView {
  final FlySwatterGame game;

  Title _title;
  StartButton _startButton;
  HelpButton _helpButton;

  HomeView(this.game) {
    _title = Title(game);
    _startButton = StartButton(game);
    _helpButton = HelpButton(game);
  }

  void update(double dt) {

  }

  void render(Canvas canvas) {
    _title.render(canvas);
    _startButton.render(canvas);
    _helpButton.render(canvas);
  }

  void onTapDown(TapDownDetails details) {
    if (_startButton.hitTest(details.globalPosition)) {
      game.play();
    }
    if (_helpButton.hitTest(details.globalPosition)) {
      game.help();
    }
  }
}