import 'package:test/test.dart';

import 'item_sorter.dart';

void main() {
  group('ItemSorter', () {
    test('sort two items', () {
      // arrange
      final itemA = Item('A');
      final itemB = Item('B');
      final sorter = ItemSorter([itemB, itemA]);
      // act
      expect(sorter.isFinished(), false);
      final itemsToCompare = sorter.nextItems();
      itemsToCompare.setSmallerItem(itemsToCompare.itemB);
      // assert
      expect(sorter.isFinished(), true);
      expect(sorter.getSortedItems(), [itemA, itemB]);
    });
  });
}
