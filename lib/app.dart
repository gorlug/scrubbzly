// import 'dart:html';

import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:jira_game/items/forge_item_board.dart';
import 'package:jira_game/items/item_sorter.dart';
import 'package:jira_game/items/item_sorter_with_delay.dart';
import 'package:jira_game/items/items_widget.dart';
import 'package:jira_game/items/sort_finished_widget.dart';
import 'package:jira_game/path_game/block.dart';
import 'package:jira_game/path_game/path_game.dart';

class App extends StatefulWidget {
  const App({Key? key}) : super(key: key);

  @override
  State<App> createState() => _AppState();
}

final List<Item> initialItems = [];

class _AppState extends State<App> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Jira Game',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

void _fillItems() {
  // for (var i = 1; i <= 20; i++) {
  //   items.add(Item('Item $i'));
  // }
  // initialItems.addAll(
  //     [Item('Issue D'), Item('Issue B'), Item('Issue C'), Item('Issue A')]);
  initialItems.addAll([Item('Issue C'), Item('Issue A'), Item('Issue B')]);
}

class _HomePageState extends State<HomePage> {
  late ItemSorter sorter;
  bool sortingStarted = false;
  bool showList = true;
  late ItemsToCompare itemsToCompare;
  bool loading = false;
  List<Item> items = [];
  bool sortFinished = false;

  @override
  void initState() {
    super.initState();
    _loadItems();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Jira Game'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: loading ? _getLoading() : _getWidgetToShow(),
      ),
    );
  }

  void _loadItems() async {
    final itemBoard = ForgeItemBoard();
    final items = await itemBoard.getItems();
    final sorter =
        ItemSorterWithDelay(items, const Duration(milliseconds: 500));
    setState(() {
      this.items = items;
      this.sorter = sorter;
      loading = false;
    });
  }

  Widget _getWidgetToShow() {
    if (sortFinished) {
      return SortFinishedWidget(sortedItems: items);
    }
    return showList
        ? ShowItemListWidget(
            sortingHasStarted: sortingStarted,
            startSorting: _startSorting,
            items: items)
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
    });
  }
}

class ShowItemListWidget extends StatelessWidget {
  final bool sortingHasStarted;
  final VoidCallback startSorting;
  final List<Item> items;

  const ShowItemListWidget({
    Key? key,
    required this.sortingHasStarted,
    required this.startSorting,
    required this.items,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      const Text('Order these issues'),
      _getSortButton(),
      Expanded(child: ItemsWidget(items: items))
    ]);
  }

  Padding _getSortButton() {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: ElevatedButton(
          onPressed: startSorting,
          child: sortingHasStarted
              ? const Text('Next comparison')
              : const Text('Start')),
    );
  }
}

class ShowGameWidget extends StatefulWidget {
  final ItemsToCompare compareItems;
  final void Function(GameEndBlock endBlock) onGameFinished;

  const ShowGameWidget(
      {Key? key, required this.compareItems, required this.onGameFinished})
      : super(key: key);

  @override
  State<ShowGameWidget> createState() => _ShowGameWidgetState();
}

class _ShowGameWidgetState extends State<ShowGameWidget> {
  bool showContinueButton = false;
  late GameEndBlock endBlock;
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
                  widget.onGameFinished(endBlock);
                },
              ),
            )
          : Container(),
      gameWrapper
      // _getPathGame()
    ]);
  }

  _onGameFinished(GameEndBlock endBlock) {
    this.endBlock = endBlock;
    setState(() {
      showContinueButton = true;
    });
  }
}

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
