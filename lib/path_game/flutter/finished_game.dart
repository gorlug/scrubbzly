import 'package:flutter/material.dart';
import 'package:jira_game/items/flutter/items_widget.dart';

import '../../items/item_sorter.dart';

class FinishedGame extends StatelessWidget {
  final VoidCallback onStartNewGame;
  final List<Item> sortedItems;

  const FinishedGame(
      {Key? key, required this.onStartNewGame, required this.sortedItems})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('You sorted all issues of your sprint!'),
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
