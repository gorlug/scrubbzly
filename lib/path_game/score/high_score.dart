import 'dart:convert';
import 'dart:js_util';

import '../../items/forge_item_sorter.dart';

const highScoreKey = 'highScore';

class HighScore {
  int _highScore = 0;

  Future<void> saveVariables() async {
    final json = {
      'highScore': _highScore,
    };
    await promiseToFuture(setStorage(highScoreKey, jsonEncode(json)));
  }

  Future<void> loadVariables() async {
    final response = await promiseToFuture(getStorage(highScoreKey));
    if (response == null) {
      return;
    }
    final json = jsonDecode(response);
    _highScore = json['highScore'] ?? 0;
  }

  Future<int> get highScore async {
    await loadVariables();
    return _highScore;
  }

  Future<void> setHighScore(int score) async {
    _highScore = score;
    await saveVariables();
  }
}
