import 'package:flutter/material.dart';

class ContinueGame extends StatelessWidget {
  final VoidCallback onContinueGame;
  final VoidCallback onStartNewGame;

  const ContinueGame(
      {Key? key, required this.onContinueGame, required this.onStartNewGame})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
            'Hello! A sorting game has already stared. Do you want to continue or start a new one?'),
        Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: ElevatedButton(
              onPressed: onContinueGame, child: const Text('Continue Game')),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: ElevatedButton(
              onPressed: onStartNewGame, child: const Text('Start New Game')),
        )
      ],
    );
  }
}
