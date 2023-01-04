import 'package:flame/components.dart';
import 'package:flame/effects.dart';
import 'package:flame/geometry.dart';
import 'package:jira_game/path_game.dart';

import 'block.dart';

class RedLineSprite extends GameBlockSprite {
  final LineOrientation orientation;

  RedLineSprite(GameBlock block, this.orientation) : super(block);

  @override
  Future<void>? onLoad() async {
    super.onLoad();
    print('on load $orientation');

    if (orientation == LineOrientation.vertical) {
      final effect = RotateEffect.by(
        tau / 4,
        EffectController(duration: 0),
      );
      add(effect);
    }
  }

  @override
  String getSprite() {
    return 'lines/line.png';
  }
}
