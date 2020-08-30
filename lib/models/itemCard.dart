import 'package:equatable/equatable.dart';

import 'package:flutter_bloc_list_manager/flutter_bloc_list_manager.dart';
import 'package:shop_0_1/src/entities/entities.dart';

// Base data class that will be supplied by the source bloc.
class ItemCard extends Equatable implements ItemClassWithAccessor {
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

  ItemCard({
    this.id,
    this.brand,
    this.model,
    this.specefication,
    this.sellPrice,
    this.buyPrice,
    this.imageUrl,
    this.barcode,
    this.startQuantity = 0,
    this.startQuantityPrice,
    this.quanitityBalance = 0,
    this.group,
  });
  ItemCard copyWith({
    String id,
    String brand,
    String model,
    List<String> specefication,
    double sellPrice,
    double buyPrice,
    String imageUrl,
    String barcode,
    int startQuantity,
    double startQuantityPrice,
    int quanitityBalance,
    String group,
  }) {
    return ItemCard(
      brand: brand ?? this.brand,
      model: model ?? this.model,
      specefication: specefication ?? this.specefication,
      sellPrice: sellPrice ?? this.sellPrice,
      buyPrice: buyPrice ?? this.buyPrice,
      imageUrl: imageUrl ?? this.imageUrl,
      barcode: barcode ?? this.barcode,
      startQuantity: startQuantity ?? this.startQuantity,
      startQuantityPrice: startQuantityPrice ?? this.startQuantityPrice,
      quanitityBalance: quanitityBalance ?? this.quanitityBalance,
      group: group ?? this.group,
    );
  }

  @override
  int get hashCode =>
      id.hashCode ^
      brand.hashCode ^
      model.hashCode ^
      specefication.hashCode ^
      sellPrice.hashCode ^
      buyPrice.hashCode ^
      imageUrl.hashCode ^
      barcode.hashCode ^
      startQuantity.hashCode ^
      startQuantityPrice.hashCode ^
      quanitityBalance.hashCode ^
      group.hashCode;

  @override
  bool operator ==(Object other) {
    identical(this, other) ||
        other is ItemCard &&
            runtimeType == other.runtimeType &&
            id == other.id &&
            brand == other.brand &&
            model == other.model &&
            specefication == other.specefication &&
            sellPrice == other.sellPrice &&
            buyPrice == other.buyPrice &&
            imageUrl == other.imageUrl &&
            barcode == other.barcode &&
            startQuantity == other.startQuantity &&
            startQuantityPrice == other.startQuantityPrice &&
            quanitityBalance == other.quanitityBalance &&
            group == other.group;
  }

  @override
  String toString() {
    return 'ItemEntity { id: $id, brand: $brand, model: $model, buyPrice: $buyPrice, sellPrice: $sellPrice, barcode: $barcode, quanitityBalance: $startQuantity, specefication: $specefication, startQuantity: $startQuantity, startQuantityPrice: $startQuantityPrice, imageUrl: $imageUrl, group: $group }';
  }

  ItemEntity toEntity() {
    return ItemEntity(
        id: id,
        brand: brand,
        model: model,
        specefication: specefication,
        sellPrice: sellPrice,
        buyPrice: buyPrice,
        imageUrl: imageUrl,
        barcode: barcode,
        startQuantity: startQuantity,
        startQuantityPrice: startQuantityPrice,
        quanitityBalance: quanitityBalance,
        group: group);
  }

  static ItemCard fromEntity(ItemEntity entity) {
    return ItemCard(
        id: entity.id,
        brand: entity.brand,
        model: entity.model,
        specefication: entity.specefication,
        sellPrice: entity.sellPrice,
        buyPrice: entity.buyPrice,
        imageUrl: entity.imageUrl,
        barcode: entity.barcode,
        startQuantity: entity.startQuantity,
        startQuantityPrice: entity.startQuantityPrice,
        quanitityBalance: entity.quanitityBalance,
        group: entity.group);
  }

  // Every prop intended to be used in a filtering or sorting operation
  // should be included in this operator overload.
  dynamic operator [](String prop) {
    switch (prop) {
      case 'brand':
        return brand;
        break;
      case 'model':
        return model;
        break;
      case 'specefication':
        return specefication;
        break;
      case 'sellPrice':
        return sellPrice;
        break;
      case 'buyPrice':
        return buyPrice;
        break;
      case 'imageUrl':
        return imageUrl;
        break;
      case 'barcode':
        return barcode;
        break;
      case 'startQuantity':
        return startQuantity;
        break;
      case 'startQuantityPrice':
        return startQuantityPrice;
        break;
      case 'quanitityBalance':
        return quanitityBalance;
        break;
      case 'group':
        return group;
        break;
      default:
        throw ArgumentError('Property `$prop` does not exist on JournalEntry.');
    }
  }

  @override
  List<Object> get props => [
        brand,
        model,
        buyPrice,
        sellPrice,
        id,
        barcode,
        imageUrl,
        quanitityBalance,
        specefication,
        startQuantity,
        startQuantityPrice,
        group,
      ];
}
