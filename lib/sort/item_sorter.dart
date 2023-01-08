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
  late List<List<Item>> _splitArrays;
  late List<List<Item>> _mergedArrays;

  late List<Item> _currentMerge;
  late List<Item> _leftArray;
  late List<Item> _rightArray;

  ItemSorter(this.itemsToSort) {
    _splitArrays = ArrayMiddleSplitter(itemsToSort).split();
    _leftArray = _splitArrays.removeAt(0);
    _rightArray = _splitArrays.removeAt(0);
    _mergedArrays = [];
    _currentMerge = [];
  }

  bool isFinished() {
    return finished;
  }

  ItemsToCompare nextItems() {
    return ItemsToCompare(this, _leftArray.first, _rightArray.first);
  }

  List<Item> getSortedItems() {
    return sortedItems;
  }

  void comparisonFinished(ItemsToCompare itemsToCompare) {
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
    print('bbq _splitArrays before: $_splitArrays');
    _mergedArrays.add(_currentMerge);
    print('bbq _mergedArrays: $_mergedArrays');
    _currentMerge = [];
    if (_splitArrays.isEmpty) {
      _splitArrays = _mergedArrays;
      _mergedArrays = [];
    }
    if (_splitArrays.length == 1) {
      sortedItems = _splitArrays.first;
      finished = true;
      return;
    }
    if (_splitArrays.isNotEmpty) {
      print('bbq _splitArrays after: $_splitArrays');
      _leftArray = _splitArrays.removeAt(0);
      _rightArray = _splitArrays.removeAt(0);
    }
  }
}

class ItemsToCompare {
  final ItemSorter sorter;
  final Item leftItem;
  final Item rightItem;
  late Item smallerItem;
  bool leftItemIsSmaller = false;

  ItemsToCompare(this.sorter, this.leftItem, this.rightItem) {
    smallerItem = leftItem;
  }

  void setSmallerItem(Item item) {
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
