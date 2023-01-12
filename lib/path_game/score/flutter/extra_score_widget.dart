import 'dart:html';

import 'package:flutter/material.dart';

import '../extra_score.dart';

class ExtraScoreWidget extends StatefulWidget {
  final ExtraScore extraScore;

  const ExtraScoreWidget({Key? key, required this.extraScore})
      : super(key: key);

  @override
  State<ExtraScoreWidget> createState() => _ExtraScoreWidgetState();
}

class _ExtraScoreWidgetState extends State<ExtraScoreWidget> {
  int seconds = 0;
  int extraScoreToShow = 0;

  @override
  void initState() {
    super.initState();
    widget.extraScore.setListeners(
        extraScoreCallback: onExtraScoreChanged,
        secondsCallback: onSecondsChanged);
    seconds = widget.extraScore.secondsLeft;
    extraScoreToShow = widget.extraScore.extraScore;
    widget.extraScore.start();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: Row(
            children: [
              const Text(
                'Extra score: ',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Text('$extraScoreToShow'),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
          child: Row(
            children: [
              const Text(
                'Seconds left: ',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Text('$seconds'),
            ],
          ),
        ),
      ],
    );
  }

  void onExtraScoreChanged(int extraScore) {
    setState(() {
      extraScoreToShow = extraScore;
    });
  }

  void onSecondsChanged(int seconds) {
    setState(() {
      this.seconds = seconds;
    });
  }
}
