import 'package:jira_game/items/item_sorter.dart';

abstract class ItemBoard<ItemType extends Item> {
  Future<List<ItemType>> getItems();

  Future<ItemSorter> createSorter();
}
