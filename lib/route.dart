import 'package:jira_game/game.dart';
import 'package:jira_game/route_block.dart';

class Route {
  final NextBlockForRouteSelector nextBlockForRouteSelector;
  List<RouteBlock> blocks = [];

  Route(this.nextBlockForRouteSelector);

  void calculateRoute(RouteBlock start, Game game) {
    blocks.add(start);
    var currentBlock = start;
    while (!currentBlock.isEndBlock) {
      currentBlock =
          nextBlockForRouteSelector.selectNextBlock(currentBlock, game);
      blocks.add(currentBlock);
    }
  }
}
