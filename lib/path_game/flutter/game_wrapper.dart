import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:jira_game/path_game/score/extra_score.dart';
import 'package:jira_game/path_game/score/flutter/extra_score_widget.dart';
import 'package:jira_game/path_game/score/flutter/total_score_widget.dart';

import '../../items/item_sorter.dart';
import '../path_game.dart';

class GameWrapper extends StatefulWidget {
  final void Function(GameEndBlock endBlock, int score) onGameFinished;
  final ItemsToCompare compareItems;

  const GameWrapper(
      {Key? key, required this.onGameFinished, required this.compareItems})
      : super(key: key);

  @override
  State<GameWrapper> createState() => _GameWrapperState();
}

class _GameWrapperState extends State<GameWrapper> {
  int totalScore = 0;
  final ExtraScore extraScore = ExtraScore();
  bool gameFinished = false;
  late Widget gameWidget;

  @override
  void initState() {
    super.initState();
    gameWidget = SizedBox(
        width: gameWidth,
        height: gameHeight,
        child: GameWidget(game: PathGame(_onGameFinished)));
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Text(
                'A: ',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Text(widget.compareItems.leftItem.name),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
            child: Row(
              children: [
                const Text(
                  'B: ',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Text(widget.compareItems.rightItem.name),
              ],
            ),
          ),
          _showScore(),
          gameWidget,
        ],
      ),
    );
  }

  Widget _showScore() {
    if (gameFinished) {
      return TotalScoreWidget(totalScore: totalScore);
    }
    return ExtraScoreWidget(extraScore: extraScore);
  }

  _onGameFinished(GameEndBlock endBlock) {
    extraScore.stop();
    setState(() {
      gameFinished = true;
      totalScore = 10 + extraScore.extraScore;
    });
    widget.onGameFinished(endBlock, totalScore);
  }
}
