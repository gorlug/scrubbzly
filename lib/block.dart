import 'package:jira_game/game.dart';
import 'package:jira_game/route_block.dart';

class GameBlock {
  final int x;
  final int y;

  GameBlock({required this.x, required this.y});

  GameBlock.fromOtherBlock(GameBlock otherBlock)
      : x = otherBlock.x,
        y = otherBlock.y;

  String toChar() {
    return 'B';
  }

  GameBlock getRightNeighbor(Game game) {
    return game.getBlock(x + 1, y);
  }

  GameBlock getLeftNeighbor(Game game) {
    return game.getBlock(x - 1, y);
  }

  GameBlock getTopNeighbor(Game game) {
    return game.getBlock(x, y - 1);
  }

  GameBlock getBottomNeighbor(Game game) {
    return game.getBlock(x, y + 1);
  }

  GameBlock getNeighbor(Game game, BlockSide side) {
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

class EmptyBlock extends GameBlock {
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

class WallBlock extends GameBlock {
  WallBlock({required super.x, required super.y});

  WallBlock.fromOtherBlock(GameBlock otherBlock)
      : super.fromOtherBlock(otherBlock);

  @override
  String toChar() {
    return 'X';
  }
}

class EndBlock extends GameBlock {
  EndBlock({required super.x, required super.y});

  @override
  String toChar() {
    return 'E';
  }
}

class StartABlock extends GameBlock {
  StartABlock({required super.x, required super.y});

  @override
  String toChar() {
    return 'A';
  }
}

class StartBBlock extends GameBlock {
  StartBBlock({required super.x, required super.y});

  @override
  String toChar() {
    return 'B';
  }
}
