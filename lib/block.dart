import 'package:jira_game/game.dart';
import 'package:jira_game/route_block.dart';

abstract class Block {
  final int x;
  final int y;

  Block({required this.x, required this.y});

  String toChar();

  Block getRightNeighbor(Game game) {
    return game.getBlock(x + 1, y);
  }

  Block getLeftNeighbor(Game game) {
    return game.getBlock(x - 1, y);
  }

  Block getTopNeighbor(Game game) {
    return game.getBlock(x, y - 1);
  }

  Block getBottomNeighbor(Game game) {
    return game.getBlock(x, y + 1);
  }

  Block getNeighbor(Game game, BlockSide side) {
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

class EmptyBlock extends Block {
  EmptyBlock({required super.x, required super.y});

  @override
  String toChar() {
    return 'O';
  }

  @override
  String toString() {
    return 'EmptyBlock{x: $x, y: $y}';
  }
}

class WallBlock extends Block {
  WallBlock({required super.x, required super.y});

  @override
  String toChar() {
    return 'X';
  }
}

class EndBlock extends Block {
  EndBlock({required super.x, required super.y});

  @override
  String toChar() {
    return 'E';
  }
}

class StartABlock extends Block {
  StartABlock({required super.x, required super.y});

  @override
  String toChar() {
    return 'A';
  }
}

class StartBBlock extends Block {
  StartBBlock({required super.x, required super.y});

  @override
  String toChar() {
    return 'B';
  }
}
