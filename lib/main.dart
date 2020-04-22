import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flame/util.dart';
import 'package:flame/flame.dart';

import 'game.dart';

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
    'bg/lose-splash.png',
    'branding/title.png',
    'ui/dialog-help.png',
    'ui/icon-help.png',
    'ui/start-button.png',
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