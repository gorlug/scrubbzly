import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:jira_game/items/forge_item_board.dart';
import 'package:jira_game/items/item_board.dart';
import 'package:jira_game/items/item_sorter.dart';
import 'package:jira_game/items/item_sorter_with_delay.dart';

import 'app.dart';
import 'path_game/path_game.dart';

void main() {
  // _loadItems();
  registerServices();
  runApp(const App());
  // runApp(GameWidget(
  //     game: PathGame(board: MockPathGameBoard(lengthX: 5, lengthY: 3))));
}

Future<void> _loadItems() async {
  final itemBoard = ForgeItemBoard();
  final items = await itemBoard.getItems();
  final array = items.map((e) => '${e.name}');
  print(array);
}

void registerServices() {
  final getIt = GetIt.instance;
  getIt.registerSingleton<ItemBoard>(ForgeItemBoard());
}
