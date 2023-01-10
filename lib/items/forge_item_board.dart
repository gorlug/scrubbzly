import 'dart:convert';
import 'dart:js' as js;
import 'dart:js_util';
import 'package:js/js.dart';
import 'dart:html';

import 'package:jira_game/items/item_board.dart';
import 'package:jira_game/items/item_sorter.dart';

@JS('window.forge.getActiveSprintIssues')
external dynamic Function() getActiveSprintIssues;

class ForgeItemBoard implements ItemBoard {
  ForgeItemBoard() {
    window.document.onContextMenu.listen((evt) => evt.preventDefault());
  }

  @override
  Future<List<Item>> getItems() async {
    print('get active sprint issues $getActiveSprintIssues');
    final response = await promiseToFuture(getActiveSprintIssues());
    print('response $response');
    final json = jsonDecode(response);
    final issues = json['issues'] as List<dynamic>;
    return issues
        .map((e) => JiraIssue(e['id'], e['fields']['summary']))
        .toList();
    // return [JiraIssue('id', 'a'), JiraIssue('id2', 'b')];
  }
}

class JiraIssue extends Item {
  final String id;

  JiraIssue(this.id, String name) : super(name);
}
