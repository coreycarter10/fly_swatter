import 'dart:ui';

import 'package:flutter/material.dart';

import '../game.dart';
import 'callout.dart';
import '../utils/sprite_set.dart';

abstract class Fly {
  static const animationSpeed = 30.0; // animate at 30fps
  static const fallSpeed = 12.0; // fall at 12 tiles per second

  final FlySwatterGame game;

  double _flySize;

  Rect _rect;
  Rect _hitRect;

  Callout _callout;

  FlyStatus _status = FlyStatus.flying;
  FlyStatus get status => _status;

  final Map<FlyStatus, SpriteSet> _sprites = {};

  Offset _targetLocation;
  double _speed; // speed is tiles per second

  Fly({
    @required this.game,
    @required List<String> flyingImagePaths,
    @required String deadImagePath,
    @required double x,
    @required double y,
    double sizeFactor = 1,
    double speed = 3,
  }) {
    _flySize = game.tileSize * sizeFactor;

    final sizeDelta = _flySize / 4;
    final _tempRect = Rect.fromLTWH(0, 0, _flySize, _flySize);
    final _inflatedRect = _tempRect.inflate(sizeDelta);

    _rect = Rect.fromLTWH(x, y, _inflatedRect.width, _inflatedRect.height);
    _hitRect = _rect.deflate(sizeDelta);
    _callout = Callout(this);

    _sprites[FlyStatus.flying] = SpriteSet.fromImagePaths(flyingImagePaths);
    _sprites[FlyStatus.dead] = SpriteSet.fromImagePaths([deadImagePath]);

    _setTargetLocation();
    _speed = speed;
  }

  void update(double dt) {
    // at 60fps, dt will be ~0.0166

    switch (_status) {
      case FlyStatus.flying:
        _fly(dt);
        if (game.view == View.playing) _callout.update(dt);
        break;
      case FlyStatus.dead: _fall(dt); break;
      default: break;
    }

    if (isOffScreen(game.screenSize)) {
      game.removeFly(this);
    }
  }

  void render(Canvas canvas) {
    _sprites[_status].currentSprite.renderRect(canvas, _rect);

    if (_status == FlyStatus.flying && game.view == View.playing) {
      _callout.render(canvas);
    }
  }

  void kill() {
    _status = FlyStatus.dead;
  }

  void _moveBy(Offset offset) {
    _rect = _rect.shift(offset);
    _hitRect = _rect.shift(offset);
  }

  void _fly(double dt) {
    // animation progresses...
    _sprites[_status].forward(animationSpeed * dt);

    // move the fly
    final distanceToMove = game.tileSize * _speed * dt;
    final offsetToTarget = _targetLocation - _rect.topLeft;

    if (distanceToMove < offsetToTarget.distance) {
      final offset = Offset.fromDirection(offsetToTarget.direction, distanceToMove);
      _moveBy(offset);
    }
    else {
      _moveBy(offsetToTarget);
      _setTargetLocation();
    }
  }

  void _fall(double dt) {
    _rect = _rect.translate(0, game.tileSize * fallSpeed * dt);
  }

  void _setTargetLocation() {
    final x = FlySwatterGame.random.nextDouble() * (game.screenSize.width - _flySize);
    final y = FlySwatterGame.random.nextDouble() * (game.screenSize.height - _flySize);

    _targetLocation = Offset(x, y);
  }

  bool hitTest(Offset offset) => _hitRect.contains(offset);
  bool isOffScreen(Size screenSize) => x < 0 || x > screenSize.width || y < 0 || y > screenSize.height;

  double get x => _rect.left;
  double get y => _rect.top;
  double get w => _rect.width;
  double get h => _rect.height;

  double get hitX => _hitRect.left;
  double get hitY => _hitRect.top;
  double get hitW => _hitRect.width;
  double get hitH => _hitRect.height;
}

class HouseFly extends Fly {
  static const flyingImagePaths = <String>['flies/house-fly-1.png', 'flies/house-fly-2.png'];
  static const deadImagePath = 'flies/house-fly-dead.png';

  HouseFly({
    @required FlySwatterGame game,
    @required double x,
    @required double y,
  }) : super(game: game, flyingImagePaths: flyingImagePaths, deadImagePath: deadImagePath, x: x, y: y);
}

class DroolerFly extends Fly {
  static const flyingImagePaths = <String>['flies/drooler-fly-1.png', 'flies/drooler-fly-2.png'];
  static const deadImagePath = 'flies/drooler-fly-dead.png';

  DroolerFly({
    @required FlySwatterGame game,
    @required double x,
    @required double y,
  }) : super(game: game, flyingImagePaths: flyingImagePaths, deadImagePath: deadImagePath, x: x, y: y, speed: 1.5);
}

class AgileFly extends Fly {
  static const flyingImagePaths = <String>['flies/agile-fly-1.png', 'flies/agile-fly-2.png'];
  static const deadImagePath = 'flies/agile-fly-dead.png';

  AgileFly({
    @required FlySwatterGame game,
    @required double x,
    @required double y,
  }) : super(game: game, flyingImagePaths: flyingImagePaths, deadImagePath: deadImagePath, x: x, y: y, speed: 5);
}

class MachoFly extends Fly {
  static const flyingImagePaths = <String>['flies/macho-fly-1.png', 'flies/macho-fly-2.png'];
  static const deadImagePath = 'flies/macho-fly-dead.png';

  MachoFly({
    @required FlySwatterGame game,
    @required double x,
    @required double y,
  }) : super(game: game, flyingImagePaths: flyingImagePaths, deadImagePath: deadImagePath, x: x, y: y, sizeFactor: 2.025, speed: 2.5);
}

class HungryFly extends Fly {
  static const flyingImagePaths = <String>['flies/hungry-fly-1.png', 'flies/hungry-fly-2.png'];
  static const deadImagePath = 'flies/hungry-fly-dead.png';

  HungryFly({
    @required FlySwatterGame game,
    @required double x,
    @required double y,
  }) : super(game: game, flyingImagePaths: flyingImagePaths, deadImagePath: deadImagePath, x: x, y: y, sizeFactor: 1.65);
}

enum FlyStatus {
  flying,
  dead,
}