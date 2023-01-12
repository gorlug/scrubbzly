import 'package:flutter/material.dart';

class TotalScoreWidget extends StatelessWidget {
  final int totalScore;

  const TotalScoreWidget({Key? key, required this.totalScore})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0, top: 8.0),
      child: Row(
        children: [
          const Text(
            'Total Score: ',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          Text('$totalScore'),
        ],
      ),
    );
  }
}
