import 'dart:convert';
import 'dart:js' as js;
import 'dart:js_util';
import 'package:jira_game/items/forge_item_sorter.dart';
import 'package:js/js.dart';
import 'dart:html';

import 'package:jira_game/items/item_board.dart';
import 'package:jira_game/items/item_sorter.dart';

@JS('window.forge.getActiveSprintIssues')
external dynamic Function() getActiveSprintIssues;

class ForgeItemBoard implements ItemBoard<JiraIssue> {
  ForgeItemBoard() {
    window.document.onContextMenu.listen((evt) => evt.preventDefault());
  }

  @override
  Future<List<JiraIssue>> getItems() async {
    final response = await promiseToFuture(getActiveSprintIssues());
    print('response $response');
    final json = jsonDecode(response);
    final issues = json['issues'] as List<dynamic>;
    return issues
        .map((e) => JiraIssue(e['id'], e['fields']['summary']))
        .toList()
        .reversed
        .toList();
    // return [JiraIssue('1', 'Issue A'), JiraIssue('2', 'Issue B')];
  }

  @override
  Future<ItemSorter> createSorter() async {
    final items = await getItems();
    return ForgeItemSorter(items);
  }
}

class JiraIssue extends Item {
  final String id;

  JiraIssue(this.id, String name) : super(name);

  dynamic toJson() {
    return {
      'id': id,
      'name': name,
    };
  }
}
