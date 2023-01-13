import 'package:flutter/material.dart';

import '../../items/item_sorter.dart';
import '../path_game.dart';
import 'game_wrapper.dart';

class ShowGameWidget extends StatefulWidget {
  final ItemsToCompare compareItems;
  final void Function(GameEndBlock endBlock, int score) onGameFinished;

  const ShowGameWidget(
      {Key? key, required this.compareItems, required this.onGameFinished})
      : super(key: key);

  @override
  State<ShowGameWidget> createState() => _ShowGameWidgetState();
}

class _ShowGameWidgetState extends State<ShowGameWidget> {
  bool showContinueButton = false;
  late GameEndBlock endBlock;
  int score = 0;
  late Widget gameWrapper;

  @override
  void initState() {
    super.initState();
    gameWrapper = GameWrapper(
      onGameFinished: _onGameFinished,
      compareItems: widget.compareItems,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      showContinueButton
          ? Padding(
              padding: const EdgeInsets.only(top: 8, bottom: 8),
              child: ElevatedButton(
                child: const Text('Continue'),
                onPressed: () {
                  widget.onGameFinished(endBlock, score);
                },
              ),
            )
          : Container(),
      gameWrapper
      // _getPathGame()
    ]);
  }

  _onGameFinished(GameEndBlock endBlock, int score) {
    this.endBlock = endBlock;
    this.score = score;
    setState(() {
      showContinueButton = true;
    });
  }
}
