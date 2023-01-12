import 'package:flame/game.dart';
import 'package:flutter/material.dart';

import '../../items/item_sorter.dart';
import '../path_game.dart';

class GameWrapper extends StatelessWidget {
  final void Function(GameEndBlock endBlock) onGameFinished;
  final ItemsToCompare compareItems;

  const GameWrapper(
      {Key? key, required this.onGameFinished, required this.compareItems})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('A: ${compareItems.leftItem.name}'),
          Padding(
            padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
            child: Text('B: ${compareItems.rightItem.name}'),
          ),
          SizedBox(
              width: gameWidth,
              height: gameHeight,
              child: GameWidget(game: PathGame(onGameFinished))),
        ],
      ),
    );
  }
}
