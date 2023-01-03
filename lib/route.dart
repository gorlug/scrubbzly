import 'package:jira_game/game.dart';
import 'package:jira_game/random_number_generator.dart';

import 'block.dart';

/// Board
///
/// X|X|X|X|X
/// x|O|O|O|X
/// E|O|O|O|S
/// X|O|O|O|X
/// X|X|X|X|X
///
/// X|X|X|X|X
/// X|O|┏|┓|X
/// E|━|┛|┗|S
/// X|O|O|O|X
/// X|X|X|X|X
///
/// X|X|X|X|X
/// X|O|┏|┓|X
/// E|┓|┃|┗|S
/// X|┗|┛|O|X
/// X|X|X|X|X
///
///

class RouteBlock extends Block {
  BlockSide start;
  BlockSide? end;

  RouteBlock({required super.x, required super.y, required this.start});

  @override
  String toChar() {
    if (start == BlockSide.left && end == BlockSide.bottom) {
      return RouteChar.leftBottom.char;
    }
    if (start == BlockSide.bottom && end == BlockSide.left) {
      return RouteChar.leftBottom.char;
    }
    if (start == BlockSide.left && end == BlockSide.top) {
      return RouteChar.leftTop.char;
    }
    if (start == BlockSide.top && end == BlockSide.left) {
      return RouteChar.leftTop.char;
    }
    if (start == BlockSide.right && end == BlockSide.bottom) {
      return RouteChar.rightBottom.char;
    }
    if (start == BlockSide.bottom && end == BlockSide.right) {
      return RouteChar.rightBottom.char;
    }
    if (start == BlockSide.right && end == BlockSide.top) {
      return RouteChar.rightTop.char;
    }
    if (start == BlockSide.top && end == BlockSide.right) {
      return RouteChar.rightTop.char;
    }
    if (start == BlockSide.left && end == BlockSide.right) {
      return RouteChar.leftRight.char;
    }
    if (start == BlockSide.right && end == BlockSide.left) {
      return RouteChar.leftRight.char;
    }
    if (start == BlockSide.top && end == BlockSide.bottom) {
      return RouteChar.topBottom.char;
    }
    return RouteChar.topBottom.char;
  }
}

class Route {
  List<RouteBlock> _blocks = [];
}

enum BlockSide {
  left,
  right,
  bottom,
  top,
}

Map<int, BlockSide> blockSides = {
  0: BlockSide.top,
  1: BlockSide.right,
  2: BlockSide.bottom,
  3: BlockSide.left,
};

Map<BlockSide, BlockSide> neighboringBlockSide = {
  BlockSide.top: BlockSide.bottom,
  BlockSide.right: BlockSide.left,
  BlockSide.bottom: BlockSide.top,
  BlockSide.left: BlockSide.right,
};

enum RouteChar {
  leftBottom,
  leftTop,
  rightBottom,
  rightTop,
  leftRight,
  topBottom,
}

extension RouteCharExtension on RouteChar {
  String get char {
    switch (this) {
      case RouteChar.leftBottom:
        return '┓';
      case RouteChar.leftTop:
        return '┛';
      case RouteChar.rightBottom:
        return '┏';
      case RouteChar.rightTop:
        return '┗';
      case RouteChar.leftRight:
        return '━';
      case RouteChar.topBottom:
        return '┃';
    }
  }
}

class NextBlockForRouteSelector {
  final RouteBlock currentBlock;
  final RandomNumberGenerator randomNumberGenerator;

  NextBlockForRouteSelector(
      {required this.currentBlock,
      this.randomNumberGenerator = const RandomNumberGeneratorImpl()});

  RouteBlock selectNextBlock(Game game) {
    final blockSide =
        blockSides[randomNumberGenerator.generateRandomNumber(4)]!;
    final block = currentBlock.getNeighbor(game, blockSide);
    currentBlock.end = blockSide;
    return RouteBlock(
        x: block.x, y: block.y, start: neighboringBlockSide[blockSide]!);
  }
}
