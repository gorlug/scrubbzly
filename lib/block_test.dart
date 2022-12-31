import 'package:jira_game/block.dart';
import 'package:jira_game/route.dart';
import 'package:test/test.dart';

import 'game.dart';

void main() {
  group('Block', ()
  {
    test('get neighbouring right block', () {
      final game = Game(lengthX: 3, lengthY: 3);
      final block = game.getBlock(3, 1);
      final rightBlock = block.getRightNeighbor(game);
      expect(rightBlock, isA<StartABlock>());
    });
  });
}
