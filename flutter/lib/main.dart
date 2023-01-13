import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:jira_game/items/forge_item_board.dart';
import 'package:jira_game/items/item_board.dart';

import 'app.dart';

void main() {
  registerServices();
  runApp(const App());
}

void registerServices() {
  final getIt = GetIt.instance;
  getIt.registerSingleton<ItemBoard>(ForgeItemBoard());
}
