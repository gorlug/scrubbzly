import 'package:flame/game.dart';
import 'package:flutter/material.dart';

import 'path_game/path_game.dart';

void main() {
  runApp(GameWidget(game: PathGame()));
  // runApp(GameWidget(
  //     game: PathGame(board: MockPathGameBoard(lengthX: 5, lengthY: 3))));
}
