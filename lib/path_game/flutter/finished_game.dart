import 'package:flutter/material.dart';
import 'package:jira_game/items/flutter/items_widget.dart';
import 'package:jira_game/path_game/score/flutter/total_score_widget.dart';

import '../../items/item_sorter.dart';

class FinishedGame extends StatelessWidget {
  final VoidCallback onStartNewGame;
  final List<Item> sortedItems;
  final int totalScore;

  const FinishedGame(
      {Key? key,
      required this.onStartNewGame,
      required this.sortedItems,
      required this.totalScore})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('You sorted all issues of your sprint!'),
        TotalScoreWidget(totalScore: totalScore),
        Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: ElevatedButton(
              onPressed: onStartNewGame, child: const Text('Start New Game')),
        ),
        Expanded(child: ItemsWidget(items: sortedItems))
      ],
    );
  }
}
