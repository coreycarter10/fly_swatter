import 'package:flame/sprite.dart';

class SpriteSet {
  final List<Sprite> sprites;
  double _index = 0.0;

  SpriteSet(this.sprites);

  factory SpriteSet.fromImagePaths(List<String> paths) {
    final List<Sprite> sprites = paths.map((String path) => Sprite(path)).toList();
    return SpriteSet(sprites);
  }

  void forward(double amt) {
    _index += amt;

    while (_index >= sprites.length) {
      _index -= sprites.length;
    }
  }

  Sprite get currentSprite => sprites[_index.toInt()];
}