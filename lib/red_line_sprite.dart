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

mixin RotateTau4 on GameBlockSprite {
  void _rotateTau(double tauValue) {
    final effect = RotateEffect.by(
      tauValue,
      EffectController(duration: 0),
    );
    add(effect);
  }
}

class CornerRedLineSprite extends GameBlockSprite with RotateTau4 {
  final CornerOrientation orientation;

  CornerRedLineSprite(GameBlock block, this.orientation) : super(block);

  @override
  Future<void>? onLoad() {
    super.onLoad();

    if (orientation == CornerOrientation.topRight) {
      _rotateTau(tau / 4);
    }

    if (orientation == CornerOrientation.bottomRight) {
      _rotateTau(tau / 2);
    }

    if (orientation == CornerOrientation.bottomLeft) {
      _rotateTau(-tau / 4);
    }
  }

  @override
  String getSprite() {
    return 'lines/corner.png';
  }
}

class TShortRedLineSprite extends GameBlockSprite with RotateTau4 {
  final TeeOrientation orientation;

  TShortRedLineSprite(GameBlock block, this.orientation) : super(block);

  @override
  Future<void>? onLoad() {
    super.onLoad();

    if (orientation == TeeOrientation.right) {
      _rotateTau(tau / 4);
    }

    if (orientation == TeeOrientation.bottom) {
      _rotateTau(tau / 2);
    }

    if (orientation == TeeOrientation.left) {
      _rotateTau(-tau / 4);
    }
  }

  void _rotateTau(double tauValue) {
    final effect = RotateEffect.by(
      tauValue,
      EffectController(duration: 0),
    );
    add(effect);
  }

  @override
  String getSprite() {
    return 'lines/t_short.png';
  }
}
