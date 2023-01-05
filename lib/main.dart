import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:jira_game/path_game.dart';

import 'mock_path_game_board.dart';

void main() {
  runApp(GameWidget(game: PathGame()));
  // runApp(GameWidget(
  //     game: PathGame(board: MockPathGameBoard(lengthX: 5, lengthY: 3))));
}
