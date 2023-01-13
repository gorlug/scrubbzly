import 'package:flutter/material.dart';

import '../item_sorter.dart';
import 'items_widget.dart';

class SortFinishedWidget extends StatelessWidget {
  final List<Item> sortedItems;

  const SortFinishedWidget({Key? key, required this.sortedItems})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      const Text('All issues sorted!'),
      Expanded(child: ItemsWidget(items: sortedItems))
    ]);
  }
}
