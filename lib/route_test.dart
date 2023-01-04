import 'package:jira_game/route.dart';
import 'package:jira_game/route_block.dart';
import 'package:jira_game/route_block_test.dart';
import 'package:test/test.dart';

import 'block.dart';
import 'game.dart';

void main() {
  group('Route', () {
    test('should backtrack if a route is a dead end', () {
      // arrange
      final game = Game(lengthX: 3, lengthY: 3);
      final startBlock = RouteBlock(x: 3, y: 1);
      final block2 = BlockWithBlockSide(EmptyBlock(x: 2, y: 1), BlockSide.left);
      final block3 =
          BlockWithBlockSide(EmptyBlock(x: 2, y: 2), BlockSide.bottom);
      final block4 =
          BlockWithBlockSide(EmptyBlock(x: 2, y: 3), BlockSide.bottom);
      final block5 =
          BlockWithBlockSide(EmptyBlock(x: 3, y: 3), BlockSide.right);
      final block6 =
          BlockWithBlockSide(EmptyBlock(x: 3, y: 2), BlockSide.bottom);
      // final routeBlock7 = RouteBlock(x: 3, y: 2, start: BlockSide.bottom);

      final nextBlock1 =
          BlockWithBlockSide(EmptyBlock(x: 1, y: 3), BlockSide.left);
      final endBlock =
          BlockWithBlockSide(EmptyBlock(x: 1, y: 2), BlockSide.top);

      final selector = MockNextBlockForRouteSelector(blocksWithBlockSides: [
        block2,
        block3,
        block4,
        block5,
        block6,
        nextBlock1,
        endBlock
      ]);
      final route = Route(selector);

      // act
      route.calculateRoute(startBlock, game);
      print(game.printBoard());

      // assert
      final routeBlock2 =
          RouteBlock(x: 2, y: 1, start: BlockSide.right, end: BlockSide.bottom);
      final routeBlock3 =
          RouteBlock(x: 2, y: 2, start: BlockSide.top, end: BlockSide.bottom);
      final routeBlock4 = RouteBlock(
        x: 2,
        y: 3,
        start: BlockSide.top,
        end: BlockSide.left,
      );
      final routeNextBlock1 =
          RouteBlock(x: 1, y: 3, start: BlockSide.right, end: BlockSide.top);
      final routeEndBlock =
          RouteBlock(x: 1, y: 2, start: BlockSide.bottom, end: BlockSide.left);
      routeEndBlock.isEndBlock = true;
      expect(
          route.blocks.toString(),
          [
            startBlock,
            routeBlock2,
            routeBlock3,
            routeBlock4,
            routeNextBlock1,
            routeEndBlock
          ].toString());
    });
  });
}

class MockNextBlockForRouteSelector extends NextBlockForRouteSelector {
  List<RouteBlock?> nextBlocks;
  List<BlockWithBlockSide?> blocksWithBlockSides;
  int nextBlocksCalled = 0;

  MockNextBlockForRouteSelector(
      {this.nextBlocks = const [], this.blocksWithBlockSides = const []});

  @override
  BlockWithBlockSide getRandomBlock(List<BlockWithBlockSide> validBlocks) {
    if (blocksWithBlockSides.isEmpty) {
      return super.getRandomBlock(validBlocks);
    }
    return blocksWithBlockSides[nextBlocksCalled++]!;
  }

  @override
  RouteBlock selectNextBlock(RouteBlock currentBlock, Game game) {
    if (nextBlocks.isEmpty) {
      return super.selectNextBlock(currentBlock, game);
    }
    final next = nextBlocks[nextBlocksCalled++];
    if (next == null) {
      throw NoNextRouteFoundException();
    }
    return next;
  }
}
