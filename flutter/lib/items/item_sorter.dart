class Item {
  final String name;

  Item(this.name);

  @override
  String toString() {
    return name;
  }
}

abstract class ItemSorter {
  Future<bool> hasStarted();

  Future<bool> isFinished();

  Future<void> start();

  Future<ItemsToCompare> nextItems();

  Future<List<Item>> getSortedItems();

  Future<List<Item>> getCurrentSort();
}

abstract class ItemsToCompare<ItemType extends Item> {
  Future<void> setSmallerItem(ItemType item);

  ItemType get leftItem;

  ItemType get rightItem;
}

abstract class ItemSorterFactory {
  ItemSorter create(List<Item> items);
}

class LocalItemSorterFactory implements ItemSorterFactory {
  @override
  ItemSorter create(List<Item> items) {
    return ItemSorterImpl(items);
  }
}

class ItemSorterImpl<ItemType extends Item> implements ItemSorter {
  final List<ItemType> itemsToSort;
  List<ItemType> sortedItems = [];
  bool started = false;
  bool finished = false;
  late List<List<ItemType>> splitArrays;
  late List<List<ItemType>> mergedArrays;

  late List<ItemType> currentMerge;
  late List<ItemType> leftArray;
  late List<ItemType> rightArray;

  ItemSorterImpl(this.itemsToSort);

  @override
  Future<bool> isFinished() async {
    return finished;
  }

  @override
  Future<ItemsToCompare> nextItems() async {
    return ItemsToCompareImpl<ItemType>(
        this, leftArray.first, rightArray.first);
  }

  @override
  Future<List<Item>> getSortedItems() async {
    return sortedItems;
  }

  Future<void> comparisonFinished(
      ItemsToCompareImpl<ItemType> itemsToCompare) async {
    currentMerge.add(itemsToCompare.smallerItem);
    if (itemsToCompare.leftItemIsSmaller) {
      leftArray.removeAt(0);
    } else {
      rightArray.removeAt(0);
    }
    await _checkForMergeFinished();
  }

  Future<void> _checkForMergeFinished() async {
    if (leftArray.isEmpty) {
      currentMerge.addAll(rightArray);
      await _finishCurrentMerge();
    } else if (rightArray.isEmpty) {
      currentMerge.addAll(leftArray);
      await _finishCurrentMerge();
    }
  }

  Future<void> _finishCurrentMerge() async {
    mergedArrays.add(currentMerge);
    currentMerge = [];
    if (splitArrays.length == 1) {
      mergedArrays.add(splitArrays.removeLast());
    }
    if (mergedArrays.length == 1 && splitArrays.isEmpty) {
      sortedItems = mergedArrays.first;
      await setFinished();
      return;
    }
    if (splitArrays.isEmpty) {
      splitArrays = mergedArrays;
      mergedArrays = [];
    }
    if (splitArrays.isNotEmpty) {
      leftArray = splitArrays.removeAt(0);
      rightArray = splitArrays.removeAt(0);
    }
  }

  Future<void> setFinished() async {
    finished = true;
  }

  @override
  Future<List<Item>> getCurrentSort() async {
    final List<Item> current = [];
    current.addAll(mergedArrays.expand((element) => element).toList());
    current.addAll(currentMerge);
    current.addAll(leftArray);
    current.addAll(rightArray);
    current.addAll(splitArrays.expand((element) => element).toList());
    return current;
  }

  @override
  Future<void> start() async {
    if (itemsToSort.length == 1) {
      started = true;
      sortedItems = itemsToSort;
      setFinished();
    } else {
      splitArrays = ArrayMiddleSplitter<ItemType>(itemsToSort).split();
      leftArray = splitArrays.removeAt(0);
      rightArray = splitArrays.removeAt(0);
      mergedArrays = [];
      currentMerge = [];
      finished = false;
      started = true;
    }
  }

  @override
  Future<bool> hasStarted() async {
    return started;
  }
}

class ItemsToCompareImpl<ItemType extends Item>
    implements ItemsToCompare<ItemType> {
  final ItemSorterImpl sorter;
  @override
  final ItemType leftItem;
  @override
  final ItemType rightItem;
  late ItemType smallerItem;
  bool leftItemIsSmaller = false;

  ItemsToCompareImpl(this.sorter, this.leftItem, this.rightItem) {
    smallerItem = leftItem;
  }

  @override
  Future<void> setSmallerItem(ItemType item) async {
    smallerItem = item;
    if (item == leftItem) {
      leftItemIsSmaller = true;
    } else {
      leftItemIsSmaller = false;
    }
    await sorter.comparisonFinished(this);
  }
}

class ArrayMiddleSplitter<ItemType extends Item> {
  final List<ItemType> initialArray;
  final List<List<ItemType>> splitArrays = [];

  ArrayMiddleSplitter(this.initialArray);

  List<List<ItemType>> split() {
    _splitArray(initialArray);
    return splitArrays;
  }

  void _splitArray(List<ItemType> array) {
    if (array.length == 1) {
      splitArrays.add(array);
      return;
    }
    final middle = array.length ~/ 2;
    final firstHalf = array.sublist(0, middle);
    final secondHalf = array.sublist(middle);
    _splitArray(firstHalf);
    _splitArray(secondHalf);
  }
}
