import 'package:jira_game/game.dart';
import 'package:jira_game/route.dart';

abstract class Block {
  final int x;
  final int y;

  Block({required this.x, required this.y});

  String toChar();

  Block getRightNeighbor(Game game) {
    return game.getBlock(x + 1, y);
  }
}

class EmptyBlock extends Block {
  EmptyBlock({required super.x, required super.y});

  @override
  String toChar() {
    return 'O';
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
