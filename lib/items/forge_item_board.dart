import 'dart:js' as js;
import 'dart:js_util';
import 'package:js/js.dart';

import 'package:jira_game/items/item_board.dart';
import 'package:jira_game/items/item_sorter.dart';

@JS()
external dynamic Function() getBoardItems;

class ForgeItemBoard implements ItemBoard {
  @override
  Future<List<Item>> getItems() async {
    final items = await promiseToFuture(getBoardItems());
    print('items: $items');
    return [];
  }
}
