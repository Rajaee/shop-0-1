import 'dart:async';

import '../item_repo_general.dart';

abstract class ItemsRepository {
  Future<void> addNewItem(ItemCard item);

  Future<void> deleteItem(ItemCard item);

  Stream<List<ItemCard>> items();

  Future<void> updateItem(ItemCard item);
}
