import 'package:flutter/material.dart';
import 'package:jira_game/path_game/flutter/continue_game.dart';
import 'package:jira_game/path_game/flutter/finished_game.dart';
import 'package:jira_game/path_game/flutter/fresh_game.dart';
import 'package:jira_game/path_game/score/total_score.dart';

import '../../app.dart';
import '../../items/item_board.dart';
import '../../items/item_sorter.dart';
import '../path_game.dart';
import 'error_getting_board_widget.dart';
import 'show_game_widget.dart';
import 'show_item_list_widget.dart';

class GamePage extends StatefulWidget {
  const GamePage({Key? key}) : super(key: key);

  @override
  State<GamePage> createState() => _GamePageState();
}

class _GamePageState extends State<GamePage> {
  late ItemSorter sorter;
  bool sortingStarted = false;
  bool showList = true;
  late ItemsToCompare itemsToCompare;
  bool loading = true;
  List<Item> items = [];
  bool sortFinished = false;
  bool gameStarted = false;
  bool showContinue = false;
  late TotalScore totalScore = TotalScore();
  int scoreNumber = 0;
  bool gettingBoardError = false;
  bool notMoreThanOneItem = false;

  @override
  void initState() {
    super.initState();
    _initSorter();
  }

  Future<void> _initSorter() async {
    try {
      final itemBoard = getIt.get<ItemBoard>();
      sorter = await itemBoard.createSorter();
      final hasStarted = await sorter.hasStarted();
      setState(() {
        showContinue = hasStarted;
        notMoreThanOneItem = sorter.itemsToSort.length <= 1;
        loading = false;
      });
    } catch (e) {
      setState(() {
        gettingBoardError = true;
        loading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return loading ? _getLoading() : _getWidgetToShow();
  }

  void _startGame(bool newGame) async {
    setState(() {
      loading = true;
    });
    if (newGame) {
      await sorter.start();
      await totalScore.resetScore();
    }
    scoreNumber = await totalScore.totalScore;
    final sortedItems = await sorter.getCurrentSort();
    setState(() {
      items = sortedItems;
      showContinue = false;
      gameStarted = true;
      sortFinished = false;
      showList = true;
      loading = false;
    });
  }

  Widget _getWidgetToShow() {
    if(gettingBoardError) {
      return const ErrorGettingBoardWidget();
    }
    if (notMoreThanOneItem) {
      return const ErrorGettingBoardWidget();
    }
    if (sortFinished) {
      return FinishedGame(
          onStartNewGame: () => _startGame(true),
          sortedItems: items,
          totalScore: scoreNumber);
    }
    if (showContinue) {
      return ContinueGame(
          onContinueGame: () => _startGame(false),
          onStartNewGame: () => _startGame(true));
    }
    if (!gameStarted) {
      return FreshGame(onStartNewGame: () => _startGame(true));
    }
    return showList
        ? ShowItemListWidget(
            startSorting: _startSorting,
            items: items,
            scoreNumber: scoreNumber,
          )
        : ShowGameWidget(
            compareItems: itemsToCompare,
            onGameFinished: _onGameFinished,
          );
  }

  Widget _getLoading() {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }

  void _startSorting() {
    setState(() {
      sortingStarted = true;
      showList = false;
      loading = true;
    });
    _loadNextItemsToCompare();
  }

  void _loadNextItemsToCompare() async {
    itemsToCompare = await sorter.nextItems();
    setState(() {
      loading = false;
    });
  }

  void _onGameFinished(GameEndBlock endBlock, int score) async {
    setState(() {
      loading = true;
    });
    if (endBlock == GameEndBlock.A) {
      await itemsToCompare.setSmallerItem(itemsToCompare.leftItem);
    } else {
      await itemsToCompare.setSmallerItem(itemsToCompare.rightItem);
    }
    final scoreNumber = await _addScore(score);
    if (await sorter.isFinished()) {
      await _onSortFinished(scoreNumber);
    } else {
      final currentSort = await sorter.getCurrentSort();
      setState(() {
        items = currentSort;
        showList = true;
        this.scoreNumber = scoreNumber;
        loading = false;
      });
    }
  }

  Future<int> _addScore(int score) async {
    await totalScore.addScore(score);
    return await totalScore.totalScore;
  }

  _onSortFinished(int scoreNumber) async {
    final sortedItems = await sorter.getSortedItems();
    setState(() {
      this.scoreNumber = scoreNumber;
      items = sortedItems;
      loading = false;
      sortFinished = true;
      gameStarted = false;
    });
  }
}
