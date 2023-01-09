// import 'dart:html';

import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:jira_game/items/item_sorter.dart';
import 'package:jira_game/items/item_sorter_with_delay.dart';
import 'package:jira_game/items/items_widget.dart';
import 'package:jira_game/path_game/path_game.dart';

class App extends StatefulWidget {
  const App({Key? key}) : super(key: key);

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  void initState() {
    super.initState();
    // document.onContextMenu.listen((event) => event.preventDefault());
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Jira Game',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

final List<Item> items = [];

void _fillItems() {
  // for (var i = 1; i <= 20; i++) {
  //   items.add(Item('Item $i'));
  // }
  items.addAll(
      [Item('Issue D'), Item('Issue B'), Item('Issue C'), Item('Issue A')]);
}

class _HomePageState extends State<HomePage> {
  late ItemSorter sorter;
  bool sortingStarted = false;
  bool showList = true;
  late ItemsToCompare itemsToCompare;
  bool loading = true;

  @override
  void initState() {
    super.initState();
    _fillItems();
    sorter = ItemSorterWithDelay(items, const Duration(milliseconds: 500));
    _loadNextItemsToCompare();
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

  Widget _getWidgetToShow() {
    return showList
        ? ShowItemListWidget(
            sortingHasStarted: sortingStarted,
            startSorting: _startSorting,
            items: items)
        : ShowGameWidget(compareItems: itemsToCompare);
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
    });
  }

  void _loadNextItemsToCompare() async {
    itemsToCompare = await sorter.nextItems();
    setState(() {
      loading = false;
    });
  }
}

class ShowItemListWidget extends StatelessWidget {
  final bool sortingHasStarted;
  final VoidCallback startSorting;
  final List<Item> items;

  const ShowItemListWidget(
      {Key? key,
      required this.sortingHasStarted,
      required this.startSorting,
      required this.items})
      : super(key: key);

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
      child:
          ElevatedButton(onPressed: startSorting, child: const Text('Start')),
    );
  }
}

class ShowGameWidget extends StatelessWidget {
  final ItemsToCompare compareItems;

  const ShowGameWidget({Key? key, required this.compareItems})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(children: [_getPathGame()]);
  }

  _getPathGame() {
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
              child: GameWidget(game: PathGame())),
        ],
      ),
    );
  }
}
