import 'package:jira_game/block.dart';
import 'package:jira_game/random_number_generator.dart';
import 'package:jira_game/route_block.dart';
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
      RouteBlock routeBlock = _createRouteBlock(game);
      final numberGenerator = MockRandomNumberGenerator(randomNumbers: [0]);
      final selector = NextBlockForRouteSelector(
          currentBlock: routeBlock, randomNumberGenerator: numberGenerator);

      // act
      final nextBlock = selector.selectNextBlock(game);

      // assert
      expect(numberGenerator.maxValues, [2]);
      expect(nextBlock.x, 3);
      expect(nextBlock.y, 2);
      expect(nextBlock.start, BlockSide.top);
      expect(routeBlock.end, BlockSide.bottom);
    });

    test('should throw an error if no valid block can be found', () {
      // arrange
      final game = Game(lengthX: 3, lengthY: 3);
      game.setBlock(WallBlock(x: 2, y: 1));
      game.setBlock(WallBlock(x: 3, y: 2));
      RouteBlock routeBlock = RouteBlock(x: 3, y: 1, start: BlockSide.left);
      final numberGenerator =
          MockRandomNumberGenerator(randomNumbers: [0, 1, 2]);
      final selector = NextBlockForRouteSelector(
          currentBlock: routeBlock, randomNumberGenerator: numberGenerator);

      // act/assert
      expect(() => selector.selectNextBlock(game),
          throwsA(const TypeMatcher<NoNextRouteFoundException>()));
    });

    test('should always choose the end block if it is available', () {
      // arrange
      final game = Game(lengthX: 3, lengthY: 3);
      RouteBlock routeBlock = RouteBlock(x: 1, y: 2, start: BlockSide.bottom);
      final numberGenerator = MockRandomNumberGenerator(randomNumbers: [0]);
      final selector = NextBlockForRouteSelector(
          currentBlock: routeBlock, randomNumberGenerator: numberGenerator);
      final nextBlock = selector.selectNextBlock(game);

      // act/assert
      expect(nextBlock.x, 1);
      expect(nextBlock.y, 2);
      expect(nextBlock.start, BlockSide.bottom);
      expect(routeBlock.end, BlockSide.left);
      expect(routeBlock.isEndBlock, true);
    });
  });
}

RouteBlock _createRouteBlock(Game game) {
  final startBlock = game.startABlock;
  final block = startBlock.getLeftNeighbor(game);
  final routeBlock = RouteBlock(x: block.x, y: block.y, start: BlockSide.right);
  return routeBlock;
}

class MockRandomNumberGenerator with RandomNumberGenerator {
  List<int> randomNumbers;
  int _timesCalled = 0;
  List<int> maxValues = [];

  MockRandomNumberGenerator({this.randomNumbers = const [0]});

  @override
  int generateRandomNumber(int max) {
    maxValues.add(max);
    final nextIndex = _timesCalled++ % randomNumbers.length;
    return randomNumbers[nextIndex];
  }
}
