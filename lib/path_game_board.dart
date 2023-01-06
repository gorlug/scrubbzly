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
    createBoard(lengthX, lengthY);
    _addBRoute(lengthX, lengthY);
  }

  void createBoard(int lengthX, int lengthY) {
    final game = _createARouteGame(lengthX, lengthY);
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
          startSprite!.routeEnd = BlockSide.right;
          row.add(startSprite!);
        }
        if (block is StartBBlock) {
          row.add(BSprite(block));
        }
        if (block is EmptyBlock) {
          // row.add(BlockSprite(block));
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
    // final index = const RandomNumberGeneratorImpl()
    //     .generateRandomNumber(sprites.values.length);
    // final sprite = sprites.values.elementAt(index)(x, y);
    const spriteCreators = [createCornerSprite, createBlockSprite];
    final randomBlock = _createRandomBlock(spriteCreators, x, y);
    row.add(randomBlock);
  }

  Game _createARouteGame(int lengthX, int lengthY) {
    final game = Game(lengthX: lengthX, lengthY: lengthY);
    final aBlock = game.startABlock;
    final leftOfABlock = aBlock.getLeftNeighbor(game);
    _addRouteToGame(leftOfABlock, game);
    return game;
  }

  Game _createBRouteGame(int lengthX, int lengthY) {
    final game = Game(lengthX: lengthX, lengthY: lengthY);
    final bBlock = game.startBBlock;
    final leftOfBBlock = bBlock.getLeftNeighbor(game);
    _addRouteToGame(leftOfBBlock, game);
    return game;
  }

  void _addRouteToGame(GameBlock leftOfABlock, Game game) {
    final startRoute = RouteBlock.fromOtherBlock(leftOfABlock);
    final selector = NextBlockForRouteSelector();
    final route = Route(selector);
    route.calculateRoute(startRoute, game);
  }

  void _addRouteBlock(RouteBlock block, List<GameBlockSprite> row) {
    final routeBlock = _createRouteBlock(block);
    row.add(routeBlock);
  }

  GameBlockSprite _createRouteBlock(RouteBlock block) {
    if (block.isCornerBlock()) {
      const spriteCreators = [
        createTeeSprite,
        createCornerSprite,
        // createCrossSprite
      ];
      return _createRandomBlock(spriteCreators, block.x, block.y);
    }
    const spriteCreators = [
      createTeeSprite,
      createLineSprite,
      // createCrossSprite
    ];
    return _createRandomBlock(spriteCreators, block.x, block.y);
  }

  _createRandomBlock(List<CreateSprite> creators, int x, int y) {
    final creator =
        creators[randomNumber.generateRandomNumber(creators.length)];
    return creator(x, y);
  }

  GameBlockSprite getBlock(int x, int y) {
    return _board[y][x];
  }

  void addBlock(int x, int y, GameBlockSprite block) {
    _board[y][x] = block;
  }

  void addRow(List<GameBlockSprite> row) {
    _board.add(row);
  }

  void _addBRoute(int lengthX, int lengthY) {
    final game = _createBRouteGame(lengthX, lengthY);
    print(game.printBoard());

    for (var y = 0; y < game.board.length; y++) {
      final boardRow = game.board[y];
      for (var x = 0; x < boardRow.length; x++) {
        final gameBlock = boardRow[x];
        if (gameBlock is RouteBlock) {
          _checkIfRouteBlockNeedsModification(gameBlock, x, y);
        }
      }
    }
  }

  void _checkIfRouteBlockNeedsModification(RouteBlock gameBlock, int x, int y) {
    final currentBlock = _board[y][x];
    if (currentBlock is BlockSprite) {
      final routeBlock = _createRouteBlock(gameBlock);
      _board[y][x] = routeBlock;
    }
    if (currentBlock is CornerSprite && !gameBlock.isCornerBlock() ||
        currentBlock is LineSprite && gameBlock.isCornerBlock()) {
      // const spriteCreators = [createTeeSprite, createCrossSprite];
      // _board[y][x] = _createRandomBlock(spriteCreators, x, y);
      _board[y][x] = createTeeSprite(x, y);
    }
  }
}

typedef CreateSprite = GameBlockSprite Function(int x, int y);

Map<int, CreateSprite> sprites = {
  0: (x, y) => createCrossSprite(x, y),
  1: (x, y) => createTeeSprite(x, y),
  2: (x, y) => createCornerSprite(x, y),
  3: (x, y) => createLineSprite(x, y),
  4: (x, y) => createBlockSprite(x, y),
};

BlockSprite createBlockSprite(int x, int y) =>
    BlockSprite(GameBlock(x: x, y: y));

CrossSprite createCrossSprite(int x, int y) =>
    CrossSprite(GameBlock(x: x, y: y));

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
