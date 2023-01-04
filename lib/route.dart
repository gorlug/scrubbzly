import 'package:jira_game/block.dart';
import 'package:jira_game/game.dart';
import 'package:jira_game/route_block.dart';

class Route {
  final NextBlockForRouteSelector nextBlockForRouteSelector;
  List<RouteBlock> blocks = [];

  Route(this.nextBlockForRouteSelector);

  void calculateRoute(RouteBlock start, Game game) {
    blocks.add(start);
    game.setBlock(start);
    var currentBlock = start;
    while (!currentBlock.isEndBlock) {
      currentBlock = _selectNextBlock(currentBlock, game);
    }
    _removeSecondToLastBlock();
  }

  RouteBlock _selectNextBlock(RouteBlock nextBlock, Game game) {
    try {
      nextBlock = nextBlockForRouteSelector.selectNextBlock(nextBlock, game);
      blocks.add(nextBlock);
      game.setBlock(nextBlock);
      return nextBlock;
    } catch (e) {
      if (e is NoNextRouteFoundException) {
        return _backTrack(nextBlock, game);
      }
      rethrow;
    }
  }

  RouteBlock _backTrack(RouteBlock nextBlock, Game game) {
    game.setBlock(WallBlock.fromOtherBlock(nextBlock));
    _removeBlockFromList(nextBlock);
    final previousBlock = blocks.last;
    return _selectNextBlock(previousBlock, game);
  }

  void _removeBlockFromList(RouteBlock nextBlock) {
    blocks.removeWhere((element) => element == nextBlock);
  }

  void _removeSecondToLastBlock() {
    if (blocks.length > 1) {
      blocks.removeAt(blocks.length - 2);
    }
  }
}
