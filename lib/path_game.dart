import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/experimental.dart';
import 'package:flame/game.dart';
import 'package:flame/geometry.dart';
import 'package:jira_game/block.dart';
import 'package:jira_game/path_game_board.dart';
import 'package:flame/effects.dart';
import 'package:jira_game/red_line_sprite.dart';
import 'package:jira_game/route_block.dart';

class PathGame extends FlameGame
    with
        HasTappableComponents,
        HorizontalDragDetector,
        SecondaryTapDetector,
        LongPressDetector {
  Set<Component> _horizontalDragComponents = {};
  List<GameBlockSprite> routeSprites = [];
  late PathGameBoard board;

  @override
  Future<void>? onLoad() async {
    super.onLoad();

    board = PathGameBoard(lengthX: 9, lengthY: 5);
    board.addToGame(this);
    routeSprites.add(board.startSprite!);
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
      if (component is RedLineAdder) {
        component.onSecondaryClick(routeSprites.last);
      }
    }
  }

  @override
  void onLongPressStart(LongPressStartInfo info) {
    super.onLongPressStart(info);
    onSecondary(info.eventPosition.game);
  }

  GameBlockSprite getBlock(int x, int y) {
    return board.getBlock(x, y);
  }

  void removeRouteSprite(GameBlockSprite sprite) {
    if (isLastRouteSprite(sprite)) {
      routeSprites.removeLast();
    }
  }

  void addRouteSprite(GameBlockSprite sprite) {
    routeSprites.add(sprite);
  }

  bool isLastRouteSprite(GameBlockSprite sprite) {
    return routeSprites.last == sprite;
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
  void onSecondaryClick(GameBlockSprite lastRouteSprite) {
    print('secondary');
    if (redLineSprite == null && _isValidRoute(lastRouteSprite)) {
      addRedLine();
    } else if (redLineSprite != null && gameRef.isLastRouteSprite(this)) {
      _removeRedLine();
    }
  }

  void addRedLine() {
    redLineSprite = createRedLineSprite();
    gameRef.add(redLineSprite!);
    gameRef.addRouteSprite(this);
  }

  GameBlockSprite createRedLineSprite();

  bool _isValidRoute(GameBlockSprite lastRouteSprite) {
    if (lastRouteSprite is StartSprite) {
      return gameRef.board.startSprite!.getRightNeighbor(gameRef) == this;
    }
    final List<GameBlockSprite> validSprites =
        blockSides.values.map((blockSide) {
      return lastRouteSprite.getNeighbor(gameRef, blockSide);
    }).toList();
    return validSprites.contains(this);
  }

  void _removeRedLine() {
    gameRef.remove(redLineSprite!);
    redLineSprite = null;
    gameRef.removeRouteSprite(this);
  }
}

abstract class GameBlockSprite extends SpriteComponent
    with HasGameRef<PathGame>, TapCallbacks {
  GameBlock block;
  final double defaultWidth = 100;
  final double defaultHeight = 100;
  GameBlockSprite? redLineSprite;
  BlockSide? routeEnd;

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

  GameBlockSprite getRightNeighbor(PathGame game) {
    return game.getBlock(block.x + 1, block.y);
  }

  GameBlockSprite getLeftNeighbor(PathGame game) {
    return game.getBlock(block.x - 1, block.y);
  }

  GameBlockSprite getTopNeighbor(PathGame game) {
    return game.getBlock(block.x, block.y - 1);
  }

  GameBlockSprite getBottomNeighbor(PathGame game) {
    return game.getBlock(block.x, block.y + 1);
  }

  GameBlockSprite getNeighbor(PathGame game, BlockSide side) {
    switch (side) {
      case BlockSide.right:
        return getRightNeighbor(game);
      case BlockSide.left:
        return getLeftNeighbor(game);
      case BlockSide.top:
        return getTopNeighbor(game);
      case BlockSide.bottom:
        return getBottomNeighbor(game);
    }
  }
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

Map<TeeOrientation, double> teeTauValues = {
  TeeOrientation.top: 0,
  TeeOrientation.right: tau / 4,
  TeeOrientation.bottom: tau / 2,
  TeeOrientation.left: tau * 3 / 4,
};

class TeeSprite extends GameBlockSprite
    with RotateComponent, RedLineAdder, RotateTau4 {
  TeeOrientation orientation;

  TeeSprite(super.block, {this.orientation = TeeOrientation.top}) {
    rotateTau(teeTauValues[orientation]!);
  }

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

Map<CornerOrientation, double> cornerTauValues = {
  CornerOrientation.topLeft: 0,
  CornerOrientation.topRight: tau / 4,
  CornerOrientation.bottomRight: tau / 2,
  CornerOrientation.bottomLeft: tau * 3 / 4,
};

class CornerSprite extends GameBlockSprite
    with RotateComponent, RedLineAdder, RotateTau4 {
  CornerOrientation orientation;

  CornerSprite(super.block, {this.orientation = CornerOrientation.topLeft}) {
    rotateTau(cornerTauValues[orientation]!);
  }

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

class LineSprite extends GameBlockSprite
    with RotateComponent, RedLineAdder, RotateTau4 {
  LineOrientation orientation;

  LineSprite(super.block, {this.orientation = LineOrientation.horizontal}) {
    rotateTau(orientation == LineOrientation.horizontal ? 0 : tau / 4);
  }

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
