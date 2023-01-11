import 'item_sorter.dart';

class ItemSorterWithDelay extends ItemSorterImpl {
  final Duration delay;

  ItemSorterWithDelay(List<Item> itemsToSort, this.delay) : super(itemsToSort);

  @override
  Future<bool> isFinished() async {
    await Future.delayed(delay);
    return super.isFinished();
  }

  @override
  Future<ItemsToCompare> nextItems() async {
    await Future.delayed(delay);
    return super.nextItems();
  }

  @override
  Future<List<Item>> getSortedItems() async {
    await Future.delayed(delay);
    return super.getSortedItems();
  }

  @override
  Future<List<Item>> getCurrentSort() async {
    await Future.delayed(delay);
    return super.getCurrentSort();
  }
}

class DelayItemSorterFactory implements ItemSorterFactory {
  @override
  ItemSorter create(List<Item> items) {
    return ItemSorterWithDelay(items, const Duration(milliseconds: 500));
  }
}
