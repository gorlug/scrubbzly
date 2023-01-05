import 'package:jira_game/path_game.dart';
import 'package:jira_game/path_game_board.dart';
import 'package:jira_game/route_block.dart';

import 'block.dart';

class MockPathGameBoard extends PathGameBoard {
  MockPathGameBoard({required super.lengthX, required super.lengthY});

  @override
  void createBoard(int lengthX, int lengthY) {
    lengthX = 4;
    lengthY = 4;

    for (var y = 0; y < lengthY; y++) {
      final row = <GameBlockSprite>[];
      for (var x = 0; x < lengthX; x++) {
        if (y == 0) {
          row.add(BlockSprite(WallBlock(x: x, y: y)));
        } else if (y == 1 && x == 0) {
          startSprite = StartSprite(EndBlock(x: x, y: y));
          row.add(startSprite!);
        } else if (y == 1 && x == lengthX - 1) {
          row.add(ASprite(WallBlock(x: x, y: y)));
        } else if (y == 2 && (x == 0 || x == lengthX - 1)) {
          row.add(BlockSprite(WallBlock(x: x, y: y)));
        } else if (y == 3) {
          row.add(BlockSprite(WallBlock(x: x, y: y)));
        } else {
          row.add(CornerSprite(RouteBlock(x: x, y: y)));
        }
      }
      addRow(row);
    }
  }
}
