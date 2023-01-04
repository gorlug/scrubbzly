import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/experimental.dart';
import 'package:flame/game.dart';
import 'package:flame/geometry.dart';
import 'package:jira_game/block.dart';
import 'package:jira_game/path_game_board.dart';
import 'package:flame/effects.dart';
import 'package:jira_game/red_line_sprite.dart';

class PathGame extends FlameGame
    with
        HasTappableComponents,
        HorizontalDragDetector,
        SecondaryTapDetector,
        LongPressDetector {
  Set<Component> _horizontalDragComponents = {};

  @override
  Future<void>? onLoad() async {
    super.onLoad();

    final board = PathGameBoard(lengthX: 9, lengthY: 5);
    board.addToGame(this);
  }

  @override
  void onHorizontalDragStart(DragStartInfo info) {
    super.onHorizontalDragStart(info);
    _horizontalDragComponents = {};
  }

  @override
  void onHorizontalDragUpdate(DragUpdateInfo info) {
    super.onHorizontalDragUpdate(info);
    final components = componentsAtPoint(info.eventPosition.game);
    _horizontalDragComponents.addAll(components);
  }

  @override
  void onHorizontalDragEnd(DragEndInfo info) {
    super.onHorizontalDragEnd(info);
    print('onHorizontalDragEnd $_horizontalDragComponents');
  }

  @override
  void onSecondaryTapDown(TapDownInfo info) {
    super.onSecondaryTapDown(info);
    onSecondary(info.eventPosition.game);
  }

  void onSecondary(Vector2 vector) {
    final components = componentsAtPoint(vector);
    for (final component in components) {
      if (component is GameBlockSprite) {
        component.onSecondaryClick();
      }
    }
  }

  @override
  void onLongPressStart(LongPressStartInfo info) {
    super.onLongPressStart(info);
    onSecondary(info.eventPosition.game);
  }
}

mixin RotateComponent on GameBlockSprite {
  @override
  void onTapUp(TapUpEvent event) {
    super.onTapUp(event);
    onRotate();
  }

  void onRotate() {
    final effect = RotateEffect.by(
      tau / 4,
      EffectController(duration: 0.3),
    );
    add(effect);
  }
}

mixin RedLineAdder on GameBlockSprite {
  @override
  void onSecondaryClick() {
    addRedLine();
  }

  void addRedLine() {
    print('secondary');
    if (redLineSprite == null) {
      redLineSprite = createRedLineSprite();
      gameRef.add(redLineSprite!);
    } else {
      gameRef.remove(redLineSprite!);
      redLineSprite = null;
    }
  }

  GameBlockSprite createRedLineSprite();
}

abstract class GameBlockSprite extends SpriteComponent
    with HasGameRef<PathGame>, TapCallbacks {
  GameBlock block;
  final double defaultWidth = 100;
  final double defaultHeight = 100;
  GameBlockSprite? redLineSprite;

  GameBlockSprite(this.block);

  @override
  Future<void>? onLoad() async {
    super.onLoad();

    sprite = await gameRef.loadSprite(getSprite());
    position = Vector2(block.x * defaultWidth + defaultWidth / 2,
        block.y * defaultHeight + defaultHeight / 2);
    width = defaultWidth;
    height = defaultHeight;
    anchor = Anchor.center;
  }

  String getSprite();

  void onSecondaryClick() {}
}

class CrossSprite extends GameBlockSprite with RedLineAdder {
  LineOrientation orientation = LineOrientation.horizontal;

  CrossSprite(super.block);

  @override
  String getSprite() {
    return 'cross.png';
  }

  @override
  GameBlockSprite createRedLineSprite() {
    return RedLineSprite(block, orientation);
  }
}

enum TeeOrientation { top, right, bottom, left }

class TeeSprite extends GameBlockSprite with RotateComponent, RedLineAdder {
  TeeOrientation orientation = TeeOrientation.top;

  TeeSprite(super.block);

  @override
  String getSprite() {
    return 'tee.png';
  }

  @override
  GameBlockSprite createRedLineSprite() {
    return TShortRedLineSprite(block, orientation);
  }

  @override
  void onRotate() {
    super.onRotate();
    orientation = TeeOrientation.values[(orientation.index + 1) % 4];
  }
}

enum CornerOrientation { topLeft, topRight, bottomRight, bottomLeft }

class CornerSprite extends GameBlockSprite with RotateComponent, RedLineAdder {
  CornerOrientation orientation = CornerOrientation.topLeft;

  CornerSprite(super.block);

  @override
  String getSprite() {
    return 'corner.png';
  }

  @override
  GameBlockSprite createRedLineSprite() {
    return CornerRedLineSprite(block, orientation);
  }

  @override
  void onRotate() {
    super.onRotate();
    orientation = CornerOrientation.values[(orientation.index + 1) % 4];
  }
}

enum LineOrientation {
  horizontal,
  vertical,
}

class LineSprite extends GameBlockSprite with RotateComponent, RedLineAdder {
  LineOrientation orientation = LineOrientation.horizontal;

  LineSprite(super.block);

  @override
  String getSprite() {
    return 'line.png';
  }

  @override
  GameBlockSprite createRedLineSprite() {
    return RedLineSprite(block, orientation);
  }

  @override
  void onRotate() {
    super.onRotate();
    orientation = orientation == LineOrientation.horizontal
        ? LineOrientation.vertical
        : LineOrientation.horizontal;
  }
}

class BlockSprite extends GameBlockSprite {
  BlockSprite(super.block);

  @override
  String getSprite() {
    return 'block.png';
  }
}

class StartSprite extends GameBlockSprite {
  StartSprite(super.block);

  @override
  String getSprite() {
    return 'start.png';
  }
}

class ASprite extends GameBlockSprite {
  ASprite(super.block);

  @override
  String getSprite() {
    return 'a.png';
  }
}

class BSprite extends GameBlockSprite {
  BSprite(super.block);

  @override
  String getSprite() {
    return 'b.png';
  }
}
