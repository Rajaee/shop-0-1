import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class ItemEntity extends Equatable {
  final String id;
  final String brand;
  final String model;
  final List<String> specefication;
  final double sellPrice;
  final double buyPrice;
  final String imageUrl;
  final String barcode;
  final int startQuantity;
  final double startQuantityPrice;
  final int quanitityBalance;
  final String group;

  ItemEntity({
    this.id,
    this.brand,
    this.model,
    this.specefication,
    this.sellPrice,
    this.buyPrice,
    this.imageUrl,
    this.barcode,
    this.startQuantity,
    this.startQuantityPrice,
    this.quanitityBalance,
    this.group,
  });

  Map<String, Object> toJson() {
    return {
      'id': id,
      'brand': brand,
      'model': model,
      'buyPrice': buyPrice,
      'sellPrice': sellPrice,
      'barcode': barcode,
      'quanitityBalance': startQuantity,
      'specefication': specefication,
      'startQuantity': startQuantity,
      'startQuantityPrice': startQuantityPrice,
      'imageUrl': imageUrl,
      'group': group,
    };
  }

  @override
  String toString() {
    return 'ItemEntity { id: $id, brand: $brand, model: $model, buyPrice: $buyPrice, sellPrice: $sellPrice, barcode: $barcode, quanitityBalance: $startQuantity, specefication: $specefication, startQuantity: $startQuantity, startQuantityPrice: $startQuantityPrice, imageUrl: $imageUrl, group: $group }';
  }

  static ItemEntity fromJson(Map<String, Object> json) {
    return ItemEntity(
      id: json['id'] as String,
      brand: json['brand'] as String,
      model: json['model'] as String,
      specefication: json['specefication'] as List<String>,
      sellPrice: json['sellPrice'] as double,
      buyPrice: json['buyPrice'] as double,
      imageUrl: json['imageUrl'] as String,
      barcode: json['barcode'] as String,
      startQuantity: json['startQuantity'] as int,
      startQuantityPrice: json['startQuantityPrice'] as double,
      quanitityBalance: json['quanitityBalance'] as int,
      group: json['group'] as String,
    );
  }

  static ItemEntity fromSnapshot(DocumentSnapshot snap) {
    return ItemEntity(
      id: snap.id,
      brand: snap.data()['brand'],
      model: snap.data()['model'],
      specefication: snap.data()['specefication'],
      sellPrice: snap.data()['sellPrice'],
      buyPrice: snap.data()['buyPrice'],
      imageUrl: snap.data()['imageUrl'],
      barcode: snap.data()['barcode'],
      startQuantity: snap.data()['startQuantity'],
      startQuantityPrice: snap.data()['startQuantityPrice'],
      quanitityBalance: snap.data()['quanitityBalance'],
      group: snap.data()['group'],
    );
  }

  Map<String, Object> toDocument() {
    return {
      'brand': brand,
      'model': model,
      'buyPrice': buyPrice,
      'sellPrice': sellPrice,
      'barcode': barcode,
      'quanitityBalance': startQuantity,
      'specefication': specefication,
      'startQuantity': startQuantity,
      'startQuantityPrice': startQuantityPrice,
      'imageUrl': imageUrl,
      'group': group,
    };
  }

  List<Object> get props {}
}
