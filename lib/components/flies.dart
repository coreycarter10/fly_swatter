import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flame/sprite.dart';

import '../game.dart';
import '../utils/sprite_set.dart';

abstract class Fly {
  FlySwatterGame game;

  Rect _rect;
  Rect _hitRect;

  FlyStatus _status = FlyStatus.flying;
  FlyStatus get status => _status;

  final Map<FlyStatus, SpriteSet> _sprites = {};

  Fly({
  @required this.game,
  @required List<String> flyingImagePaths,
  @required String deadImagePath,
  @required double x,
  @required double y,
  }) {
    _sprites[FlyStatus.flying] = SpriteSet.fromImagePaths(flyingImagePaths);
    _sprites[FlyStatus.dead] = SpriteSet.fromImagePaths([deadImagePath]);

    final sizeFactor = game.tileSize / 4;
    final _tempRect = Rect.fromLTWH(x, y , game.tileSize, game.tileSize);
    final _inflatedRect = _tempRect.inflate(sizeFactor);

    _rect = Rect.fromLTWH(x, y, _inflatedRect.width, _inflatedRect.height);
    _hitRect = _rect.deflate(sizeFactor);
  }

  void update(double dt);

  void render(Canvas canvas) {
    _sprites[_status].currentSprite.renderRect(canvas, _rect);
  }

  bool hitTest(Offset offset) => _hitRect.contains(offset);
  bool isOffScreen(Size screenSize) => x < 0 || x > screenSize.width || y < 0 || y > screenSize.height;


  double get x => _rect.left;
  double get y => _rect.top;
  double get w => _rect.width;
  double get h => _rect.height;
}

//class HouseFly extends Fly {
//  HouseFly({
//  @required FlySwatterGame game,
//  @required double x,
//  @required double y,
//  }) : super(game: game, x: x, y: y);
//}

enum FlyStatus {
  flying,
  dead,
}
