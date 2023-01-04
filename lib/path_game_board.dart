import 'package:jira_game/path_game.dart';
import 'package:jira_game/random_number_generator.dart';

import 'block.dart';

class PathGameBoard {
  final List<List<GameBlockSprite>> _board = [];

  PathGameBoard({required int lengthX, required int lengthY}) {
    lengthY += 2;
    lengthX += 2;
    final middle = lengthY ~/ 2;
    final startA = lengthY ~/ 4;
    final startB = lengthY - startA - 1;
    for (var y = 0; y < lengthY; y++) {
      final row = <GameBlockSprite>[];
      for (var x = 0; x < lengthX; x++) {
        if (y == middle && x == 0) {
          row.add(StartSprite(GameBlock(x: x, y: y)));
        } else if (y == startA && x == lengthX - 1) {
          row.add(ASprite(GameBlock(x: x, y: y)));
        } else if (y == startB && x == lengthX - 1) {
          row.add(BSprite(GameBlock(x: x, y: y)));
        } else if (y == 0 || x == 0 || x == lengthX - 1 || y == lengthY - 1) {
          row.add(BlockSprite(GameBlock(x: x, y: y)));
        } else {
          _addRandomSprite(row, x, y);
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
}

typedef CreateSprite = GameBlockSprite Function(int x, int y);

Map<int, CreateSprite> sprites = {
  0: (x, y) => CrossSprite(GameBlock(x: x, y: y)),
  1: (x, y) => TeeSprite(GameBlock(x: x, y: y)),
  2: (x, y) => CornerSprite(GameBlock(x: x, y: y)),
  3: (x, y) => LineSprite(GameBlock(x: x, y: y)),
  4: (x, y) => BlockSprite(GameBlock(x: x, y: y)),
};
