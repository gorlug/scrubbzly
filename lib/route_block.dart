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
  bool isEndBlock;

  RouteBlock(
      {required super.x,
      required super.y,
      this.start = BlockSide.right,
      this.end,
      this.isEndBlock = false});

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

  @override
  String toString() {
    return 'RouteBlock{x: $x, y: $y, start: $start, end: $end, isEndBlock: $isEndBlock}';
  }
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
  final RandomNumberGenerator randomNumberGenerator;

  NextBlockForRouteSelector(
      {this.randomNumberGenerator = const RandomNumberGeneratorImpl()});

  RouteBlock selectNextBlock(RouteBlock currentBlock, Game game) {
    final validBlocks = _getValidBlocks(currentBlock, game);
    if (validBlocks.isEmpty) {
      throw NoNextRouteFoundException();
    }

    if (_containsEndBlock(validBlocks)) {
      return _returnCurrentBlockAsEndRouteBlock(currentBlock, validBlocks);
    }

    BlockWithBlockSide nextBlockWithBlockSide = getRandomBlock(validBlocks);
    final block = nextBlockWithBlockSide.block;

    currentBlock.end = nextBlockWithBlockSide.blockSide;
    return RouteBlock(
        x: block.x,
        y: block.y,
        start: neighboringBlockSide[nextBlockWithBlockSide.blockSide]!);
  }

  RouteBlock _returnCurrentBlockAsEndRouteBlock(
      RouteBlock currentBlock, List<BlockWithBlockSide> validBlocks) {
    final endBlockWithSide = _getEndBlock(validBlocks);
    currentBlock.isEndBlock = true;
    currentBlock.end = endBlockWithSide.blockSide;
    return currentBlock;
  }

  bool _isValidBlock(Block block) {
    return block is EmptyBlock || block is EndBlock;
  }

  List<BlockWithBlockSide> _getValidBlocks(RouteBlock currentBlock, Game game) {
    return blockSides.values
        .map((blockSide) {
          final block = currentBlock.getNeighbor(game, blockSide);
          return BlockWithBlockSide(block, blockSide);
        })
        .where((blockWithBlockSide) => _isValidBlock(blockWithBlockSide.block))
        .toList();
  }

  bool _containsEndBlock(List<BlockWithBlockSide> blocks) {
    return blocks.any((element) => element.block is EndBlock);
  }

  BlockWithBlockSide _getEndBlock(List<BlockWithBlockSide> validBlocks) {
    return validBlocks.firstWhere((element) => element.block is EndBlock);
  }

  BlockWithBlockSide getRandomBlock(List<BlockWithBlockSide> validBlocks) {
    final randomIndex =
        randomNumberGenerator.generateRandomNumber(validBlocks.length);
    return validBlocks[randomIndex];
  }
}

class NoNextRouteFoundException implements Exception {}

class BlockWithBlockSide {
  final Block block;
  final BlockSide blockSide;

  BlockWithBlockSide(this.block, this.blockSide);
}
