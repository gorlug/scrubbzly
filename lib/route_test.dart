import 'package:jira_game/random_number_generator.dart';
import 'package:jira_game/route.dart';
import 'package:test/test.dart';

import 'game.dart';

void expectRouteChar(BlockSide start, BlockSide end, String expectedChar) {
  final block = RouteBlock(start: start, x: 0, y: 0);
  block.end = end;
  expect(block.toChar(), expectedChar);
}

void main() {
  group('map route block to character', () {
    test('should map left bottom', () {
      expectRouteChar(
          BlockSide.left, BlockSide.bottom, RouteChar.leftBottom.char);
    });

    test('should map bottom left', () {
      expectRouteChar(
          BlockSide.bottom, BlockSide.left, RouteChar.leftBottom.char);
    });

    test('should map left top', () {
      expectRouteChar(BlockSide.left, BlockSide.top, RouteChar.leftTop.char);
    });

    test('should map top left', () {
      expectRouteChar(BlockSide.top, BlockSide.left, RouteChar.leftTop.char);
    });

    test('should map right bottom', () {
      expectRouteChar(
          BlockSide.right, BlockSide.bottom, RouteChar.rightBottom.char);
    });

    test('should map bottom right', () {
      expectRouteChar(
          BlockSide.bottom, BlockSide.right, RouteChar.rightBottom.char);
    });

    test('should map right top', () {
      expectRouteChar(BlockSide.right, BlockSide.top, RouteChar.rightTop.char);
    });

    test('should map top right', () {
      expectRouteChar(BlockSide.top, BlockSide.right, RouteChar.rightTop.char);
    });

    test('should map left right', () {
      expectRouteChar(
          BlockSide.left, BlockSide.right, RouteChar.leftRight.char);
    });

    test('should map right left', () {
      expectRouteChar(
          BlockSide.right, BlockSide.left, RouteChar.leftRight.char);
    });

    test('should map top bottom', () {
      expectRouteChar(
          BlockSide.top, BlockSide.bottom, RouteChar.topBottom.char);
    });

    test('should map bottom top', () {
      expectRouteChar(
          BlockSide.bottom, BlockSide.top, RouteChar.topBottom.char);
    });
  });

  group('NextBlockFourRouteSelector', () {
    test('should select the next route randomly', () {
      // arrange
      final game = Game(lengthX: 3, lengthY: 3);
      final startBlock = game.startABlock;
      final block = startBlock.getLeftNeighbor(game);
      final routeBlock =
          RouteBlock(x: block.x, y: block.y, start: BlockSide.right);
      final numberGenerator = MockRandomNumberGenerator(randomNumber: 2);

      final selector = NextBlockForRouteSelector(
          currentBlock: routeBlock, randomNumberGenerator: numberGenerator);

      // act
      final nextBlock = selector.selectNextBlock(game);

      // assert
      expect(nextBlock.x, 3);
      expect(nextBlock.y, 2);
      expect(nextBlock.start, BlockSide.top);
      expect(routeBlock.end, BlockSide.bottom);
    });
  });
}

class MockRandomNumberGenerator with RandomNumberGenerator {
  int randomNumber;

  MockRandomNumberGenerator({this.randomNumber = 0});

  @override
  int generateRandomNumber(int max) {
    return randomNumber;
  }
}
