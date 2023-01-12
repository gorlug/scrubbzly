import 'package:flutter/material.dart';

import '../item_sorter.dart';

class ItemsWidget extends StatelessWidget {
  final List<Item> items;

  const ItemsWidget({Key? key, required this.items}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: items
          .map((item) => ListTile(
                title: Text(item.name),
              ))
          .toList(),
    );
  }
}
