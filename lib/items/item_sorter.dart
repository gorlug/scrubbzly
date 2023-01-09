class Item {
  final String name;

  Item(this.name);

  @override
  String toString() {
    return name;
  }
}

abstract class ItemSorter {
  Future<bool> isFinished();

  Future<ItemsToCompare> nextItems();

  Future<List<Item>> getSortedItems();
}

abstract class ItemsToCompare {
  Future<void> setSmallerItem(Item item);

  Item get leftItem;

  Item get rightItem;
}

class ItemSorterImpl implements ItemSorter {
  final List<Item> itemsToSort;
  List<Item> sortedItems = [];
  bool finished = false;
  late List<List<Item>> _splitArrays;
  late List<List<Item>> _mergedArrays;

  late List<Item> _currentMerge;
  late List<Item> _leftArray;
  late List<Item> _rightArray;

  ItemSorterImpl(this.itemsToSort) {
    if (itemsToSort.length == 1) {
      sortedItems = itemsToSort;
      finished = true;
    } else {
      _splitArrays = ArrayMiddleSplitter(itemsToSort).split();
      _leftArray = _splitArrays.removeAt(0);
      _rightArray = _splitArrays.removeAt(0);
      _mergedArrays = [];
      _currentMerge = [];
    }
  }

  @override
  Future<bool> isFinished() async {
    return finished;
  }

  @override
  Future<ItemsToCompare> nextItems() async {
    return ItemsToCompareImpl(this, _leftArray.first, _rightArray.first);
  }

  @override
  Future<List<Item>> getSortedItems() async {
    return sortedItems;
  }

  void comparisonFinished(ItemsToCompareImpl itemsToCompare) {
    _currentMerge.add(itemsToCompare.smallerItem);
    if (itemsToCompare.leftItemIsSmaller) {
      _leftArray.removeAt(0);
    } else {
      _rightArray.removeAt(0);
    }
    _checkForMergeFinished();
  }

  void _checkForMergeFinished() {
    if (_leftArray.isEmpty) {
      _currentMerge.addAll(_rightArray);
      _finishCurrentMerge();
    } else if (_rightArray.isEmpty) {
      _currentMerge.addAll(_leftArray);
      _finishCurrentMerge();
    }
  }

  void _finishCurrentMerge() {
    _mergedArrays.add(_currentMerge);
    _currentMerge = [];
    if (_splitArrays.length == 1) {
      _mergedArrays.add(_splitArrays.removeLast());
    }
    if (_mergedArrays.length == 1 && _splitArrays.isEmpty) {
      sortedItems = _mergedArrays.first;
      finished = true;
      return;
    }
    if (_splitArrays.isEmpty) {
      _splitArrays = _mergedArrays;
      _mergedArrays = [];
    }
    if (_splitArrays.isNotEmpty) {
      _leftArray = _splitArrays.removeAt(0);
      _rightArray = _splitArrays.removeAt(0);
    }
  }
}

class ItemsToCompareImpl extends ItemsToCompare {
  final ItemSorterImpl sorter;
  @override
  final Item leftItem;
  @override
  final Item rightItem;
  late Item smallerItem;
  bool leftItemIsSmaller = false;

  ItemsToCompareImpl(this.sorter, this.leftItem, this.rightItem) {
    smallerItem = leftItem;
  }

  @override
  Future<void> setSmallerItem(Item item) async {
    smallerItem = item;
    if (item == leftItem) {
      leftItemIsSmaller = true;
    } else {
      leftItemIsSmaller = false;
    }
    sorter.comparisonFinished(this);
  }
}

class ArrayMiddleSplitter {
  final List<Item> initialArray;
  final List<List<Item>> splitArrays = [];

  ArrayMiddleSplitter(this.initialArray);

  List<List<Item>> split() {
    _splitArray(initialArray);
    return splitArrays;
  }

  void _splitArray(List<Item> array) {
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
