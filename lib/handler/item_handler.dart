import 'package:flutter/material.dart';

import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/itemCard.dart';

class ItemsHandler {
  CollectionReference itemsRef = FirebaseFirestore.instance.collection('items');

  Future<void> addItem(
    String brand,
    String model,
    List<String> specefication,
    double sellPrice,
    double buyPrice,
    String barcode,
    int startQuantity,
    double startQuantityPrice,
  ) {
    print('22222222222222222222222222222222');

    return itemsRef
        .add({
          'brand': brand,
          'model': model,
          'buyPrice': buyPrice,
          'sellPrice': sellPrice,
          'barcode': barcode,
          'quanitityBalance': startQuantity,
          'specefication': specefication,
          'startQuantity': startQuantity,
          'startQuantityPrice': startQuantityPrice,
        })
        .then((value) => print('Item Added'))
        .catchError((erroe) => print('Faild adding Item'));
  }

  void test() {
    print('88888888888888888888888888888888');
  }
}
