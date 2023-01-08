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
      itemsToCompare.setSmallerItem(itemsToCompare.rightItem);
      // assert
      expect(sorter.isFinished(), true);
      expect(sorter.getSortedItems(), [itemA, itemB]);
    });

    test('sort four items', () {
      // arrange
      final itemA = Item('A');
      final itemB = Item('B');
      final itemC = Item('C');
      final itemD = Item('D');
      final sorter = ItemSorter([itemD, itemB, itemA, itemC]);
      // itemB, itemD | itemA, itemC
      // itemA, itemB
      // itemB, itemC
      // act
      expect(sorter.isFinished(), false);
      var itemsToCompare = sorter.nextItems();
      expect(itemsToCompare.leftItem, itemD);
      expect(itemsToCompare.rightItem, itemB);
      itemsToCompare.setSmallerItem(itemsToCompare.rightItem);

      expect(sorter.isFinished(), false);
      itemsToCompare = sorter.nextItems();
      expect(itemsToCompare.leftItem, itemA);
      expect(itemsToCompare.rightItem, itemC);
      itemsToCompare.setSmallerItem(itemsToCompare.leftItem);

      expect(sorter.isFinished(), false);
      itemsToCompare = sorter.nextItems();
      expect(itemsToCompare.leftItem, itemB);
      expect(itemsToCompare.rightItem, itemA);
      itemsToCompare.setSmallerItem(itemsToCompare.rightItem);

      expect(sorter.isFinished(), false);
      itemsToCompare = sorter.nextItems();
      expect(itemsToCompare.leftItem, itemB);
      expect(itemsToCompare.rightItem, itemC);
      itemsToCompare.setSmallerItem(itemsToCompare.leftItem);

      expect(sorter.isFinished(), false);
      itemsToCompare = sorter.nextItems();
      expect(itemsToCompare.leftItem, itemD);
      expect(itemsToCompare.rightItem, itemC);
      itemsToCompare.setSmallerItem(itemsToCompare.rightItem);

      expect(sorter.isFinished(), true);
      expect(sorter.getSortedItems(), [itemA, itemB, itemC, itemD]);
    });

    test('array middle splitter', () {
      // arrange
      final itemA = Item('A');
      final itemB = Item('B');
      final itemC = Item('B');
      final itemD = Item('B');
      final splitter = ArrayMiddleSplitter([itemD, itemB, itemA, itemC]);

      // act
      final splitArrays = splitter.split();

      // assert
      expect(splitArrays, [[itemD], [itemB], [itemA], [itemC]]);
    });
  });
}
