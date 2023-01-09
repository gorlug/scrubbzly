import 'dart:ui';

import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/experimental.dart';
import 'package:flame/game.dart';
import 'package:flame/geometry.dart';
import 'package:jira_game/path_game/block.dart';
import 'package:flame/effects.dart';

import 'path_game_board.dart';
import 'redraw_red_line_to_green.dart';
import 'route_block.dart';
import 'red_line_sprite.dart';

const double defaultWidth = 60;
const double defaultHeight = 60;

// const boardLengthX = 9;
// const boardLengthY = 8;
const boardLengthX = 3;
const boardLengthY = 3;

const double gameWidth = defaultWidth * (boardLengthX + 2);
const double gameHeight = defaultHeight * (boardLengthY + 2);

enum GameEndBlock {
  A,
  B,
}

class PathGame extends FlameGame
    with
        HasTappableComponents,
        HorizontalDragDetector,
        SecondaryTapDetector,
        LongPressDetector {
  Set<Component> _horizontalDragComponents = {};
  List<GameBlockSprite> routeSprites = [];
  late PathGameBoard board;
  bool gameFinished = false;
  void Function(GameEndBlock endBlock) onGameFinished;

  PathGame(this.onGameFinished);

  @override
  Future<void>? onLoad() async {
    await super.onLoad();

    board = PathGameBoard(lengthX: boardLengthX, lengthY: boardLengthY);
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
    if (gameFinished) {
      return;
    }
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

  void setGameFinished(GameEndBlock endBlock) {
    gameFinished = true;
    redRawRedLineToGreen(routeSprites);
    onGameFinished(endBlock);
  }
}

mixin RotateComponent on GameBlockSprite {
  @override
  void onTapUp(TapUpEvent event) {
    super.onTapUp(event);
    if (gameRef.gameFinished) {
      return;
    }
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
    if (redLineSprite == null &&
        _isValidRouteAndSetRouteStartAndEnd(lastRouteSprite)) {
      addRedLine();
    } else if (redLineSprite != null && gameRef.isLastRouteSprite(this)) {
      _removeRedLine();
      routeStart = null;
      routeEnd = null;
    }
  }

  void addRedLine() {
    if (this is EndSprite) {
      return;
    }
    redLineSprite = createRedLineSprite();
    gameRef.add(redLineSprite!);
    gameRef.addRouteSprite(this);
  }

  GameBlockSprite createRedLineSprite();

  bool _isValidRouteAndSetRouteStartAndEnd(GameBlockSprite lastRouteSprite) {
    print('lastRouteSprite $lastRouteSprite');
    final isNeighbor = _spriteIsNeighbor(lastRouteSprite);
    if (isNeighbor.sprite == null) {
      return false;
    }
    var oppositeBlockSide = getOppositeBlockSide(isNeighbor.blockSide);
    if (getOpenBlockSides().contains(oppositeBlockSide) &&
        lastRouteSprite.isBlockSideOpen(isNeighbor.blockSide)) {
      _updateRouteStartAndEnd(oppositeBlockSide, lastRouteSprite, isNeighbor);
      return true;
    }
    return false;
  }

  void _updateRouteStartAndEnd(BlockSide oppositeBlockSide,
      GameBlockSprite lastRouteSprite, SpriteWithBlockSide isNeighbor) {
    routeStart = oppositeBlockSide;
    lastRouteSprite.routeEnd = isNeighbor.blockSide;
    if (lastRouteSprite is RedLineAdder) {
      lastRouteSprite.redLineRedraw();
    }
    if (this is EndSprite) {
      (this as EndSprite).onRouteEnd();
    }
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

  void redLineRedraw() {
    _removeRedLine();
    addRedLine();
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

  bool isBlockSideOpen(BlockSide blockSide) {
    print('blockSide $blockSide, ${getOpenBlockSides()}');
    return getOpenBlockSides().contains(blockSide);
  }
}

mixin CornerRouteStartEndLogic on RedLineAdder {
  GameBlockSprite? getCornerRedLineSprite() {
    if (routeStart == BlockSide.top && routeEnd == BlockSide.left ||
        routeStart == BlockSide.left && routeEnd == BlockSide.top) {
      return CornerRedLineSprite(block, CornerOrientation.topLeft);
    }
    if (routeStart == BlockSide.top && routeEnd == BlockSide.right ||
        routeStart == BlockSide.right && routeEnd == BlockSide.top) {
      return CornerRedLineSprite(block, CornerOrientation.topRight);
    }
    if (routeStart == BlockSide.bottom && routeEnd == BlockSide.right ||
        routeStart == BlockSide.right && routeEnd == BlockSide.bottom) {
      return CornerRedLineSprite(block, CornerOrientation.bottomRight);
    }
    if (routeStart == BlockSide.bottom && routeEnd == BlockSide.left ||
        routeStart == BlockSide.left && routeEnd == BlockSide.bottom) {
      return CornerRedLineSprite(block, CornerOrientation.bottomLeft);
    }
    return null;
  }
}

class CrossSprite extends GameBlockSprite
    with RedLineAdder, CornerRouteStartEndLogic {
  LineOrientation orientation = LineOrientation.horizontal;

  CrossSprite(super.block);

  @override
  String getSprite() {
    return 'cross.png';
  }

  @override
  GameBlockSprite createRedLineSprite() {
    final cornerSprite = getCornerRedLineSprite();
    if (cornerSprite != null) {
      return cornerSprite;
    }
    if (routeStart == BlockSide.left || routeStart == BlockSide.right) {
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
    with RotateComponent, RedLineAdder, RotateTau4, CornerRouteStartEndLogic {
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
    final cornerSprite = getCornerRedLineSprite();
    if (cornerSprite != null) {
      return cornerSprite;
    }
    if ((routeStart == BlockSide.bottom || routeStart == BlockSide.top) &&
        (orientation == TeeOrientation.right ||
            orientation == TeeOrientation.left)) {
      return RedLineSprite(block, LineOrientation.vertical);
    }
    if ((routeStart == BlockSide.left || routeStart == BlockSide.right) &&
        (orientation == TeeOrientation.top ||
            orientation == TeeOrientation.bottom)) {
      return RedLineSprite(block, LineOrientation.horizontal);
    }
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

mixin EndSprite on RedLineAdder {
  @override
  List<BlockSide> getOpenBlockSides() {
    return [BlockSide.left];
  }

  void onRouteEnd() {
    print('onRouteEnd');
    gameRef.setGameFinished(getEndBlock());
    final effect = ColorEffect(
      const Color(0xFF00FF00),
      const Offset(0.0, 0.4),
      EffectController(duration: 0),
    );
    add(effect);
  }

  @override
  GameBlockSprite createRedLineSprite() {
    throw UnimplementedError();
  }

  GameEndBlock getEndBlock();
}

class ASprite extends GameBlockSprite with RedLineAdder, EndSprite {
  ASprite(super.block);

  @override
  String getSprite() {
    return 'a.png';
  }

  @override
  GameEndBlock getEndBlock() {
    return GameEndBlock.A;
  }
}

class BSprite extends GameBlockSprite with RedLineAdder, EndSprite {
  BSprite(super.block);

  @override
  String getSprite() {
    return 'b.png';
  }

  @override
  GameEndBlock getEndBlock() {
    return GameEndBlock.B;
  }
}
