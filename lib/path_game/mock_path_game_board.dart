import 'block.dart';
import 'path_game.dart';
import 'path_game_board.dart';
import 'route_block.dart';

class MockPathGameBoard extends PathGameBoard {
  MockPathGameBoard({required super.lengthX, required super.lengthY});

  @override
  void createBoard(int lengthX, int lengthY) {
    lengthX = 5;
    lengthY = 5;

    for (var y = 0; y < lengthY; y++) {
      final row = <GameBlockSprite>[];
      if (y == 1) {
        startSprite = StartSprite(EndBlock(x: 0, y: y));
        row.addAll([
          startSprite!,
          getTeeSprite(1, y),
          getTeeSprite(2, y),
          getTeeSprite(3, y),
          ASprite(WallBlock(x: 4, y: y)),
        ]);
      }
      if (y == 2) {
        row.addAll([
          getBlockSprite(0, y),
          getTeeSprite(1, y),
          getTeeSprite(2, y),
          getTeeSprite(3, y),
          getBlockSprite(4, y),
        ]);
      }
      if (y == 3) {
        row.addAll([
          getBlockSprite(0, y),
          getTeeSprite(1, y),
          getTeeSprite(2, y),
          getTeeSprite(3, y),
          getBlockSprite(4, y),
        ]);
      }
      for (var x = 0; x < lengthX; x++) {
        if (y == 0) {
          row.add(BlockSprite(WallBlock(x: x, y: y)));
        } else if (y == 4) {
          row.add(BlockSprite(WallBlock(x: x, y: y)));
        }
      }
      addRow(row);
    }
  }

  getCornerSprite(int x, int y) {
    return CornerSprite(RouteBlock(x: x, y: y));
  }

  getLineSprite(int x, int y) {
    return LineSprite(RouteBlock(x: x, y: y));
  }

  getBlockSprite(int x, int y) {
    return BlockSprite(WallBlock(x: x, y: y));
  }

  getTeeSprite(int x, int y) {
    return TeeSprite(RouteBlock(x: x, y: y));
  }

  getCrossSprite(int x, int y) {
    return CrossSprite(RouteBlock(x: x, y: y));
  }
}
