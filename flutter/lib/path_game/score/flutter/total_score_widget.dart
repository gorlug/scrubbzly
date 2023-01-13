import 'package:flutter/material.dart';

class ShowScoreWidget extends StatelessWidget {
  final int totalScore;
  final String label;

  const ShowScoreWidget(
      {Key? key, required this.totalScore, this.label = 'Total Score'})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0, top: 8.0),
      child: Row(
        children: [
          Text(
            '$label: ',
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          Text('$totalScore'),
        ],
      ),
    );
  }
}
