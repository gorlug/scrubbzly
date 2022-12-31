import 'package:test/test.dart';

import 'game.dart';

void main() {
  group('Game', () {
    test('initial game board', () {
      final game = Game(lengthX: 3, lengthY: 3);
      print(game.printBoard());
      const String expectedBoard = '''XXXXX
XOOOX
XOOOX
XOOOX
XXXXX
''';
      expect(game.printBoard(), expectedBoard);
    });
  });
}
