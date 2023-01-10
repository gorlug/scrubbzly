import 'package:jira_game/items/item_sorter.dart';

abstract class ItemBoard {
  Future<List<Item>> getItems();
}
