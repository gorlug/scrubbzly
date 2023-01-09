import 'package:test/test.dart';

import 'item_sorter.dart';

void main() {
  group('ItemSorter', () {
    test('sort two items', () async {
      // arrange
      final itemA = Item('A');
      final itemB = Item('B');
      final sorter = ItemSorterImpl([itemB, itemA]);
      // act
      expect(await sorter.isFinished(), false);
      final itemsToCompare = await sorter.nextItems();
      await itemsToCompare.setSmallerItem(itemsToCompare.rightItem);
      // assert
      expect(await sorter.isFinished(), true);
      expect(await sorter.getSortedItems(), [itemA, itemB]);
    });

    test('sort four items', () async {
      // arrange
      final itemA = Item('A');
      final itemB = Item('B');
      final itemC = Item('C');
      final itemD = Item('D');
      final sorter = ItemSorterImpl([itemD, itemB, itemA, itemC]);
      // itemB, itemD | itemA, itemC
      // itemA, itemB
      // itemB, itemC
      // act
      expect(await sorter.isFinished(), false);
      var itemsToCompare = await sorter.nextItems();
      expect(itemsToCompare.leftItem, itemD);
      expect(itemsToCompare.rightItem, itemB);
      await itemsToCompare.setSmallerItem(itemsToCompare.rightItem);

      expect(await sorter.isFinished(), false);
      itemsToCompare = await sorter.nextItems();
      expect(itemsToCompare.leftItem, itemA);
      expect(itemsToCompare.rightItem, itemC);
      await itemsToCompare.setSmallerItem(itemsToCompare.leftItem);

      expect(await sorter.isFinished(), false);
      itemsToCompare = await sorter.nextItems();
      expect(itemsToCompare.leftItem, itemB);
      expect(itemsToCompare.rightItem, itemA);
      await itemsToCompare.setSmallerItem(itemsToCompare.rightItem);

      expect(await sorter.isFinished(), false);
      itemsToCompare = await sorter.nextItems();
      expect(itemsToCompare.leftItem, itemB);
      expect(itemsToCompare.rightItem, itemC);
      await itemsToCompare.setSmallerItem(itemsToCompare.leftItem);

      expect(await sorter.isFinished(), false);
      itemsToCompare = await sorter.nextItems();
      expect(itemsToCompare.leftItem, itemD);
      expect(itemsToCompare.rightItem, itemC);
      await itemsToCompare.setSmallerItem(itemsToCompare.rightItem);

      expect(await sorter.isFinished(), true);
      expect(await sorter.getSortedItems(), [itemA, itemB, itemC, itemD]);
    });

    test('sort three items', () async {
      // arrange
      final itemA = Item('A');
      final itemB = Item('B');
      final itemC = Item('C');
      final sorter = ItemSorterImpl([itemC, itemB, itemA]);
      // act
      // itemC, itemB
      expect(await sorter.isFinished(), false);
      var itemsToCompare = await sorter.nextItems();
      await itemsToCompare.setSmallerItem(itemsToCompare.rightItem);

      // itemB, itemC | itemA
      expect(await sorter.isFinished(), false);
      itemsToCompare = await sorter.nextItems();
      await itemsToCompare.setSmallerItem(itemsToCompare.rightItem);

      // assert
      expect(await sorter.isFinished(), true);
      expect(await sorter.getSortedItems(), [itemA, itemB, itemC]);
    });

    test('sort one item', () async {
      // arrange
      final itemA = Item('A');
      final sorter = ItemSorterImpl([itemA]);
      // act
      expect(await sorter.isFinished(), true);
      // assert
      expect(await sorter.getSortedItems(), [itemA]);
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
      expect(splitArrays, [
        [itemD],
        [itemB],
        [itemA],
        [itemC]
      ]);
    });
  });
}
