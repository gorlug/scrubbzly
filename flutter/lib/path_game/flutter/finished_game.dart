import 'package:flutter/material.dart';
import 'package:jira_game/items/flutter/items_widget.dart';
import 'package:jira_game/path_game/score/flutter/total_score_widget.dart';
import 'package:jira_game/path_game/score/high_score.dart';

import '../../items/item_sorter.dart';

class FinishedGame extends StatefulWidget {
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
  State<FinishedGame> createState() => _FinishedGameState();
}

class _FinishedGameState extends State<FinishedGame> {
  bool loading = true;
  bool newHighScore = false;
  int highScore = 0;

  @override
  void initState() {
    super.initState();
    _loadHighScore();
  }

  @override
  Widget build(BuildContext context) {
    return loading
        ? _getLoading()
        : Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('You sorted all issues of your sprint!'),
              ShowScoreWidget(totalScore: widget.totalScore),
              newHighScore
                  ? const Text(
                      'New high score!',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    )
                  : Container(),
              ShowScoreWidget(totalScore: highScore, label: 'High Score'),
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: ElevatedButton(
                    onPressed: widget.onStartNewGame,
                    child: const Text('Start New Game')),
              ),
              Expanded(child: ItemsWidget(items: widget.sortedItems))
            ],
          );
  }

  Widget _getLoading() {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }

  Future<void> _loadHighScore() async {
    final highScoreClass = HighScore();
    int highScore = await highScoreClass.highScore;
    bool newHighScore = false;
    if (widget.totalScore > highScore) {
      newHighScore = true;
      await highScoreClass.setHighScore(widget.totalScore);
      highScore = widget.totalScore;
    }
    setState(() {
      this.highScore = highScore;
      this.newHighScore = newHighScore;
      loading = false;
    });
  }
}
