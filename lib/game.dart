import 'package:jira_game/block.dart';

class Game {
  final List<List<Block>> _board = [];

  Game({required int lengthX, required int lengthY}) {
    lengthY += 2;
    lengthX += 2;
    for (var y = 0; y < lengthY; y++) {
      final row = <Block>[];
      for (var x = 0; x < lengthX; x++) {
        if (y == 0 || x == 0 || x == lengthX - 1 || y == lengthY - 1) {
          row.add(WallBlock());
        } else {
          row.add(EmptyBlock());
        }
      }
      _board.add(row);
    }
  }

  String printBoard() {
    final buffer = StringBuffer();
    for (var y = 0; y < _board.length; y++) {
      for (var x = 0; x < _board[y].length; x++) {
        buffer.write(_board[y][x].toChar());
      }
      buffer.writeln();
    }
    return buffer.toString();
  }
}
