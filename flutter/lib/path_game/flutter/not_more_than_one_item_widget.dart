import 'package:flutter/material.dart';

class ErrorGettingBoardWidget extends StatelessWidget {
  const ErrorGettingBoardWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Text('There was an error getting the scrum board issues.', style: TextStyle(color: Colors.red),);
  }
}
