import 'package:flutter/material.dart';
import 'package:jira_game/path_game/flutter/continue_game.dart';
import 'package:jira_game/path_game/flutter/finished_game.dart';
import 'package:jira_game/path_game/flutter/fresh_game.dart';

import '../../app.dart';
import '../../items/flutter/sort_finished_widget.dart';
import '../../items/item_board.dart';
import '../../items/item_sorter.dart';
import '../path_game.dart';
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

  @override
  void initState() {
    super.initState();
    _initSorter();
  }

  Future<void> _initSorter() async {
    final itemBoard = getIt.get<ItemBoard>();
    sorter = await itemBoard.createSorter();
    final hasStarted = await sorter.hasStarted();
    setState(() {
      showContinue = hasStarted;
      loading = false;
    });
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
    }
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
    if (sortFinished) {
      return FinishedGame(
          onStartNewGame: () => _startGame(true), sortedItems: items);
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
        ? ShowItemListWidget(startSorting: _startSorting, items: items)
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

  void _onGameFinished(GameEndBlock endBlock) async {
    setState(() {
      loading = true;
    });
    print('endBlock: $endBlock');
    if (endBlock == GameEndBlock.A) {
      await itemsToCompare.setSmallerItem(itemsToCompare.leftItem);
    } else {
      await itemsToCompare.setSmallerItem(itemsToCompare.rightItem);
    }
    if (await sorter.isFinished()) {
      await _onSortFinished();
    } else {
      final currentSort = await sorter.getCurrentSort();
      setState(() {
        items = currentSort;
        showList = true;
        loading = false;
      });
    }
  }

  _onSortFinished() async {
    final sortedItems = await sorter.getSortedItems();
    setState(() {
      items = sortedItems;
      loading = false;
      sortFinished = true;
      gameStarted = false;
    });
  }
}
