import 'package:jira_game/path_game.dart';
import 'package:jira_game/random_number_generator.dart';
import 'package:jira_game/route.dart';
import 'package:jira_game/route_block.dart';

import 'block.dart';
import 'game.dart';

class PathGameBoard {
  final List<List<GameBlockSprite>> _board = [];
  StartSprite? startSprite;

  PathGameBoard({required int lengthX, required int lengthY}) {
    final game = _createGame(lengthX, lengthY);
    print(game.printBoard());

    for (var y = 0; y < game.board.length; y++) {
      final row = <GameBlockSprite>[];
      final boardRow = game.board[y];
      for (var x = 0; x < boardRow.length; x++) {
        final block = boardRow[x];
        if (block is WallBlock) {
          row.add(BlockSprite(block));
        }
        if (block is StartABlock) {
          row.add(ASprite(block));
        }
        if (block is EndBlock) {
          startSprite = StartSprite(block);
          row.add(startSprite!);
        }
        if (block is StartBBlock) {
          row.add(BSprite(block));
        }
        if (block is EmptyBlock) {
          _addRandomSprite(row, x, y);
        }
        if (block is RouteBlock) {
          _addRouteBlock(block, row);
        }
      }
      _board.add(row);
    }
  }

  void addToGame(PathGame game) {
    for (var y = 0; y < _board.length; y++) {
      for (var x = 0; x < _board[y].length; x++) {
        game.add(_board[y][x]);
      }
    }
  }

  void _addRandomSprite(List<GameBlockSprite> row, int x, int y) {
    final index = const RandomNumberGeneratorImpl()
        .generateRandomNumber(sprites.values.length);
    final sprite = sprites.values.elementAt(index)(x, y);
    row.add(sprite);
  }

  Game _createGame(int lengthX, int lengthY) {
    final game = Game(lengthX: lengthX, lengthY: lengthY);
    final aBlock = game.startABlock;
    final leftOfABlock = aBlock.getLeftNeighbor(game);
    final startRoute = RouteBlock.fromOtherBlock(leftOfABlock);
    final selector = NextBlockForRouteSelector();
    final route = Route(selector);
    route.calculateRoute(startRoute, game);
    return game;
  }

  void _addRouteBlock(RouteBlock block, List<GameBlockSprite> row) {
    if (block.toChar() == RouteChar.leftBottom.char ||
        block.toChar() == RouteChar.leftTop.char ||
        block.toChar() == RouteChar.rightBottom.char ||
        block.toChar() == RouteChar.rightTop.char) {
      const spriteCreators = [createTeeSprite, createCornerSprite];
      final creator = spriteCreators[
          randomNumber.generateRandomNumber(spriteCreators.length)];
      row.add(creator(block.x, block.y));
    }
    if (block.toChar() == RouteChar.leftRight.char ||
        block.toChar() == RouteChar.topBottom.char) {
      const spriteCreators = [createTeeSprite, createLineSprite];
      final creator = spriteCreators[
          randomNumber.generateRandomNumber(spriteCreators.length)];
      row.add(creator(block.x, block.y));
    }
  }

  GameBlockSprite getBlock(int x, int y) {
    return _board[y][x];
  }
}

typedef CreateSprite = GameBlockSprite Function(int x, int y);

Map<int, CreateSprite> sprites = {
  0: (x, y) => CrossSprite(GameBlock(x: x, y: y)),
  1: (x, y) => createTeeSprite(x, y),
  2: (x, y) => createCornerSprite(x, y),
  3: (x, y) => createLineSprite(x, y),
  4: (x, y) => BlockSprite(GameBlock(x: x, y: y)),
};

LineSprite createLineSprite(int x, int y) {
  final orientation =
      LineOrientation.values[randomNumber.generateRandomNumber(2)];
  return LineSprite(GameBlock(x: x, y: y), orientation: orientation);
}

const randomNumber = RandomNumberGeneratorImpl();

CornerSprite createCornerSprite(int x, int y) {
  final orientation =
      CornerOrientation.values[randomNumber.generateRandomNumber(4)];
  return CornerSprite(GameBlock(x: x, y: y), orientation: orientation);
}

TeeSprite createTeeSprite(int x, int y) {
  final teeOrientation =
      TeeOrientation.values[randomNumber.generateRandomNumber(4)];
  return TeeSprite(GameBlock(x: x, y: y), orientation: teeOrientation);
}
