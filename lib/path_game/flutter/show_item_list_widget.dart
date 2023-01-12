import 'package:flutter/material.dart';

import '../../items/flutter/items_widget.dart';
import '../../items/item_sorter.dart';

class ShowItemListWidget extends StatelessWidget {
  final VoidCallback startSorting;
  final List<Item> items;

  const ShowItemListWidget({
    Key? key,
    required this.startSorting,
    required this.items,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      const Text('Order these issues'),
      _getSortButton(),
      Expanded(child: ItemsWidget(items: items))
    ]);
  }

  Padding _getSortButton() {
    return Padding(
        padding: const EdgeInsets.only(top: 8.0),
        child: ElevatedButton(
            onPressed: startSorting, child: const Text('Next sort')));
  }
}
