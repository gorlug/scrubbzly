import 'package:jira_game/route.dart';
import 'package:jira_game/route_block.dart';
import 'package:test/test.dart';

import 'block.dart';
import 'game.dart';

void main() {
  group('Route', () {
    test('should finish when the end RouteBlock is found', () {
      // arrange
      final game = Game(lengthX: 3, lengthY: 3);
      final routeBlock = RouteBlock(x: 1, y: 0, start: BlockSide.bottom);
      routeBlock.end = BlockSide.left;
      routeBlock.isEndBlock = true;
      final selector = MockNextBlockForRouteSelector([routeBlock]);
      final route = Route(selector);
      final startRouteBlock = RouteBlock(x: 0, y: 0, start: BlockSide.top);

      // act
      route.calculateRoute(startRouteBlock, game);

      // assert
      expect(route.blocks, [startRouteBlock, routeBlock]);
    });
  });
}

class MockNextBlockForRouteSelector extends NextBlockForRouteSelector {
  List<RouteBlock> nextBlocks;
  int nextBlocksCalled = 0;

  MockNextBlockForRouteSelector(this.nextBlocks);

  @override
  RouteBlock selectNextBlock(RouteBlock currentBlock, Game game) {
    return nextBlocks[nextBlocksCalled++];
  }
}
