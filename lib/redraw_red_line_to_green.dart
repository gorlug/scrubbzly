import 'dart:ui';

import 'package:flame/effects.dart';
import 'package:jira_game/path_game.dart';

void redRawRedLineToGreen(List<GameBlockSprite> routeSprites) {
  for (var route in routeSprites) {
    if (route.redLineSprite != null) {
      final effect = ColorEffect(
        const Color(0xFF00FF00),
        const Offset(0.0, 1),
        EffectController(duration: 0),
      );
      route.redLineSprite!.add(effect);
    }
  }
}
