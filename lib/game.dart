import 'package:jira_game/block.dart';

class Game {
  final List<List<Block>> _board = [];

  Game({required int lengthX, required int lengthY}) {
    lengthY += 2;
    lengthX += 2;
    final middle = lengthY ~/ 2;
    final startA = lengthY ~/ 4;
    final startB = lengthY - startA - 1;
    for (var y = 0; y < lengthY; y++) {
      final row = <Block>[];
      for (var x = 0; x < lengthX; x++) {
        if (y == middle && x == 0) {
          row.add(EndBlock(x: x, y: y));
        }
        else if (y == startA && x == lengthX - 1) {
          row.add(StartABlock(x: x, y: y));
        }
        else if (y == startB && x == lengthX - 1) {
          row.add(StartBBlock(x: x, y: y));
        }
        else if (y == 0 || x == 0 || x == lengthX - 1 || y == lengthY - 1) {
          row.add(WallBlock(x: x, y: y));
        } else {
          row.add(EmptyBlock(x: x, y: y));
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

  Block getBlock(int x, int y) {
    return _board[y][x];
  }
}
