class Item {
  final String name;

  Item(this.name);

  @override
  String toString() {
    return name;
  }
}

class ItemSorter {
  final List<Item> itemsToSort;
  List<Item> sortedItems = [];
  bool finished = false;

  ItemSorter(this.itemsToSort);

  bool isFinished() {
    return finished;
  }

  ItemsToCompare nextItems() {
    return ItemsToCompare(this, itemsToSort[0], itemsToSort[1]);
  }

  List<Item> getSortedItems() {
    return sortedItems;
  }

  void comparisonFinished(ItemsToCompare itemsToCompare) {
    sortedItems.add(itemsToCompare.smallerItem);
    sortedItems.add(itemsToCompare.biggerItem);
    finished = true;
  }
}

class ItemsToCompare {
  final ItemSorter sorter;
  final Item itemA;
  final Item itemB;
  late Item smallerItem;
  late Item biggerItem;

  ItemsToCompare(this.sorter, this.itemA, this.itemB) {
    smallerItem = itemA;
  }

  void setSmallerItem(Item item) {
    smallerItem = item;
    if (item == itemA) {
      biggerItem = itemB;
    } else {
      biggerItem = itemA;
    }
    sorter.comparisonFinished(this);
  }
}
