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
    if (redLineSprite == null &&
        _isValidRouteAndSetRouteStart(lastRouteSprite)) {
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

  bool _isValidRouteAndSetRouteStart(GameBlockSprite lastRouteSprite) {
    final isNeighbor = _spriteIsNeighbor(lastRouteSprite);
    if (isNeighbor.sprite == null) {
      return false;
    }
    var oppositeBlockSide = getOppositeBlockSide(isNeighbor.blockSide);
    if (getOpenBlockSides().contains(oppositeBlockSide)) {
      routeStart = oppositeBlockSide;
      return true;
    }
    return false;
  }

  void _removeRedLine() {
    gameRef.remove(redLineSprite!);
    redLineSprite = null;
    gameRef.removeRouteSprite(this);
  }

  SpriteWithBlockSide _spriteIsNeighbor(GameBlockSprite lastRouteSprite) {
    if (lastRouteSprite is StartSprite) {
      return gameRef.board.startSprite!.getRightNeighbor(gameRef) == this
          ? SpriteWithBlockSide(lastRouteSprite, BlockSide.right)
          : SpriteWithBlockSide(null, BlockSide.right);
    }
    return blockSides.values.map((blockSide) {
      return SpriteWithBlockSide(
          lastRouteSprite.getNeighbor(gameRef, blockSide), blockSide);
    }).firstWhere((spriteWithBlockSide) {
      return spriteWithBlockSide.sprite == this;
    }, orElse: () => SpriteWithBlockSide(null, BlockSide.right));
  }
}

class SpriteWithBlockSide {
  final GameBlockSprite? sprite;
  final BlockSide blockSide;

  SpriteWithBlockSide(this.sprite, this.blockSide);
}

abstract class GameBlockSprite extends SpriteComponent
    with HasGameRef<PathGame>, TapCallbacks {
  GameBlock block;
  final double defaultWidth = 100;
  final double defaultHeight = 100;
  GameBlockSprite? redLineSprite;
  BlockSide? routeStart;
  BlockSide? routeEnd;

  GameBlockSprite(this.block);

  @override
  Future<void>? onLoad() async {
    await super.onLoad();

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

  List<BlockSide> getOpenBlockSides() {
    return [];
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
    if (routeStart! == BlockSide.left || routeStart! == BlockSide.right) {
      return RedLineSprite(block, LineOrientation.horizontal);
    }
    return RedLineSprite(block, LineOrientation.vertical);
  }

  @override
  List<BlockSide> getOpenBlockSides() {
    return [BlockSide.left, BlockSide.right, BlockSide.top, BlockSide.bottom];
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

  @override
  List<BlockSide> getOpenBlockSides() {
    if (orientation == TeeOrientation.top) {
      return [BlockSide.left, BlockSide.top, BlockSide.right];
    }
    if (orientation == TeeOrientation.right) {
      return [BlockSide.top, BlockSide.right, BlockSide.bottom];
    }
    if (orientation == TeeOrientation.bottom) {
      return [BlockSide.right, BlockSide.bottom, BlockSide.left];
    }
    return [BlockSide.bottom, BlockSide.left, BlockSide.top];
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

  @override
  List<BlockSide> getOpenBlockSides() {
    if (orientation == CornerOrientation.topLeft) {
      return [BlockSide.left, BlockSide.top];
    }
    if (orientation == CornerOrientation.topRight) {
      return [BlockSide.top, BlockSide.right];
    }
    if (orientation == CornerOrientation.bottomRight) {
      return [BlockSide.right, BlockSide.bottom];
    }
    return [BlockSide.bottom, BlockSide.left];
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

  @override
  List<BlockSide> getOpenBlockSides() {
    if (orientation == LineOrientation.horizontal) {
      return [BlockSide.left, BlockSide.right];
    }
    return [BlockSide.top, BlockSide.bottom];
  }
}

class BlockSprite extends GameBlockSprite {
  BlockSprite(super.block);

  @override
  String getSprite() {
    return 'block.png';
  }

  @override
  List<BlockSide> getOpenBlockSides() {
    return [];
  }
}

class StartSprite extends GameBlockSprite {
  StartSprite(super.block);

  @override
  String getSprite() {
    return 'start.png';
  }

  @override
  List<BlockSide> getOpenBlockSides() {
    return [BlockSide.right];
  }
}

class ASprite extends GameBlockSprite {
  ASprite(super.block);

  @override
  String getSprite() {
    return 'a.png';
  }

  @override
  List<BlockSide> getOpenBlockSides() {
    return [BlockSide.left];
  }
}

class BSprite extends GameBlockSprite {
  BSprite(super.block);

  @override
  String getSprite() {
    return 'b.png';
  }

  @override
  List<BlockSide> getOpenBlockSides() {
    return [BlockSide.left];
  }
}
