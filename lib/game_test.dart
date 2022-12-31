import 'package:test/test.dart';

import 'block.dart';
import 'game.dart';

void main() {
  group('Game', () {
    test('initial game board', () {
      final game = Game(lengthX: 3, lengthY: 3);
      print(game.printBoard());
      const String expectedBoard = '''XXXXX
XOOOA
EOOOX
XOOOB
XXXXX
''';
      expect(game.printBoard(), expectedBoard);
    });

    test('get start block A', () {
      final game = Game(lengthX: 3, lengthY: 3);
      final startBlock = game.getBlock(4, 1);
      expect(startBlock, isA<StartABlock>());
    });
  });
}
