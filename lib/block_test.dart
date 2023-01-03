import 'package:jira_game/block.dart';
import 'package:jira_game/route_block.dart';
import 'package:test/test.dart';

import 'game.dart';

void main() {
  group('Block', () {
    test('get neighbouring right block', () {
      final game = Game(lengthX: 3, lengthY: 3);
      final block = game.getBlock(3, 1);
      final rightBlock = block.getRightNeighbor(game);
      expect(rightBlock, isA<StartABlock>());
    });

    test('get neighbouring left block', () {
      final game = Game(lengthX: 3, lengthY: 3);
      final block = game.getBlock(1, 2);
      final leftBlock = block.getLeftNeighbor(game);
      expect(leftBlock, isA<EndBlock>());
    });

    test('get neighbouring top block', () {
      final game = Game(lengthX: 3, lengthY: 3);
      final block = game.getBlock(1, 1);
      final topBlock = block.getTopNeighbor(game);
      expect(topBlock, isA<WallBlock>());
    });

    test('get neighbouring bottom block', () {
      final game = Game(lengthX: 3, lengthY: 3);
      final block = game.getBlock(0, 1);
      final bottomBlock = block.getBottomNeighbor(game);
      expect(bottomBlock, isA<EndBlock>());
    });
  });
}
