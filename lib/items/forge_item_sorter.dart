import 'dart:convert';

import 'dart:js' as js;
import 'dart:js_util';
import 'package:js/js.dart';
import 'dart:html';

import 'package:jira_game/items/forge_item_board.dart';
import 'package:jira_game/items/item_sorter.dart';

@JS('window.forge.setStorage')
external dynamic Function(String key, String value) setStorage;

@JS('window.forge.getStorage')
external dynamic Function(String key) getStorage;

@JS('window.forge.deleteStorage')
external dynamic Function(String key) deleteStorage;

const itemSorterKey = 'itemSorterVariables';

class ForgeItemSorter extends ItemSorterImpl<JiraIssue> {
  ForgeItemSorter(List<JiraIssue> itemsToSort) : super(itemsToSort);

  Future<void> saveVariables() async {
    final dynamic variables = {
      'sortedItems': sortedItems.map((e) => e.toJson()).toList(),
      'started': started,
      'finished': finished,
      'splitArrays':
          splitArrays.map((e) => e.map((e) => e.toJson()).toList()).toList(),
      'mergedArrays':
          mergedArrays.map((e) => e.map((e) => e.toJson()).toList()).toList(),
      'currentMerge': currentMerge.map((e) => e.toJson()).toList(),
      'leftArray': leftArray.map((e) => e.toJson()).toList(),
      'rightArray': rightArray.map((e) => e.toJson()).toList(),
    };
    await promiseToFuture(setStorage(itemSorterKey, jsonEncode(variables)));
  }

  Future<bool> loadVariables() async {
    final response = await promiseToFuture(getStorage(itemSorterKey));
    if (response == null) {
      print('load variables is null');
      return false;
    }
    print('load response $response');
    final json = jsonDecode(response);
    sortedItems = (json['sortedItems'] as List<dynamic>)
        .map((e) => JiraIssue(e['id'], e['name']))
        .toList();
    started = json['started'];
    finished = json['finished'];
    splitArrays = (json['splitArrays'] as List<dynamic>)
        .map((e) => (e as List<dynamic>)
            .map((e) => JiraIssue(e['id'], e['name']))
            .toList())
        .toList();
    mergedArrays = (json['mergedArrays'] as List<dynamic>)
        .map((e) => (e as List<dynamic>)
            .map((e) => JiraIssue(e['id'], e['name']))
            .toList())
        .toList();
    currentMerge = (json['currentMerge'] as List<dynamic>)
        .map((e) => JiraIssue(e['id'], e['name']))
        .toList();
    leftArray = (json['leftArray'] as List<dynamic>)
        .map((e) => JiraIssue(e['id'], e['name']))
        .toList();
    rightArray = (json['rightArray'] as List<dynamic>)
        .map((e) => JiraIssue(e['id'], e['name']))
        .toList();
    return true;
  }

  Future<void> deleteVariables() async {
    print('delete variables');
    await promiseToFuture(deleteStorage(itemSorterKey));
  }

  @override
  Future<void> start() async {
    // final loaded = await loadVariables();
    // print('start loaded $loaded');
    // if (loaded) {
    //   return;
    // }
    await super.start();
    await saveVariables();
    print('leftArray $leftArray');
  }

  @override
  Future<ItemsToCompare<Item>> nextItems() async {
    final compare = await super.nextItems();
    await saveVariables();
    return compare;
  }

  @override
  Future<bool> isFinished() async {
    // await loadVariables();
    final finished = await super.isFinished();
    if (finished) {
      await deleteVariables();
    }
    return finished;
  }

  @override
  Future<List<Item>> getSortedItems() async {
    // await loadVariables();
    return super.getSortedItems();
  }

  @override
  Future<void> comparisonFinished(
      ItemsToCompareImpl<JiraIssue> itemsToCompare) async {
    await super.comparisonFinished(itemsToCompare);
    await saveVariables();
  }

  @override
  Future<bool> hasStarted() async {
    await loadVariables();
    print('has started $started');
    return super.hasStarted();
  }
}
