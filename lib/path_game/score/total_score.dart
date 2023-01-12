import 'dart:convert';
import 'dart:js_util';

import '../../items/forge_item_sorter.dart';

const totalScoreKey = 'totalScore';

class TotalScore {
  int _totalScore = 0;

  Future<void> saveVariables() async {
    final json = {
      'totalScore': _totalScore,
    };
    await promiseToFuture(setStorage(totalScoreKey, jsonEncode(json)));
  }

  Future<void> loadVariables() async {
    final response = await promiseToFuture(getStorage(totalScoreKey));
    if (response == null) {
      print('score load variables is null');
      return;
    }
    print('score load response $response');
    final json = jsonDecode(response);
    _totalScore = json['totalScore'] ?? 0;
  }

  Future<int> get totalScore async {
    await loadVariables();
    return _totalScore;
  }

  Future<void> addScore(int score) async {
    _totalScore += score;
    await saveVariables();
  }

  Future<void> resetScore() async {
    _totalScore = 0;
    await promiseToFuture(deleteStorage(totalScoreKey));
  }
}
