import 'package:flutter/material.dart';

class ErrorGettingBoardWidget extends StatelessWidget {
  const ErrorGettingBoardWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Text('There are less than two issues on the scrum board. Add more issues to play the game.');
  }
}
