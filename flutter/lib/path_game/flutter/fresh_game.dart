import 'package:flutter/material.dart';

class FreshGame extends StatelessWidget {
  final VoidCallback onStartNewGame;

  const FreshGame({Key? key, required this.onStartNewGame}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
            'Hello! You can start a new game to sort alle the issues in your current sprint.'),
        Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: ElevatedButton(
              onPressed: onStartNewGame, child: const Text('Start New Game')),
        )
      ],
    );
  }
}
