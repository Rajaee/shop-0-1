import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import '../item_repo_general.dart';
import 'entities/entities.dart';

class FirebaseItemsRepository implements ItemsRepository {
  final itemCollection = FirebaseFirestore.instance.collection('items');

  @override
  Future<void> addNewItem(ItemCard item) {
    return itemCollection.add(item.toEntity().toDocument());
  }

  @override
  Future<void> deleteItem(ItemCard item) async {
    return itemCollection.doc(item.id).delete();
  }

  @override
  Stream<List<ItemCard>> items() {
    print('XXXXXXXXXXXXXXXXXXXXXXXXXXXX');
    return itemCollection.snapshots().map((snapshot) {
      return snapshot.documents
          .map((doc) => ItemCard.fromEntity(ItemEntity.fromSnapshot(doc)))
          .toList();
    });
  }

  @override
  Future<void> updateItem(ItemCard update) {
    return itemCollection.doc(update.id).update(update.toEntity().toDocument());
  }
}
