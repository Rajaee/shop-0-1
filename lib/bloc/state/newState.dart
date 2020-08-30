import 'package:equatable/equatable.dart';

import '../../models/itemCard.dart';
import 'package:flutter_bloc_list_manager/flutter_bloc_list_manager.dart';

// The base state for the source bloc.
abstract class ItemCardState extends Equatable {
  const ItemCardState();
}

// State of the source bloc where items have not yet been loaded.
class Loading extends ItemCardState {
  @override
  List<Object> get props =>
      ['Loading', 'adding', 'deleting', 'updating', 'updatings'];
}

// State of the source bloc that indicates items have been loaded
// and are ready for further processing.
class Loaded extends ItemCardState implements ItemSourceState<ItemCard> {
  final List<ItemCard> items;

  const Loaded(this.items);

  @override
  List<Object> get props => [items];
}

class Adding extends ItemCardState {
  final List<ItemCard> items;
  const Adding(this.items);
  void adding(ItemCard item) {
    items.add(item);
  }

  @override
  List<Object> get props => [items];
}

class Updating extends ItemCardState {
  final List<ItemCard> items;
  const Updating(this.items);
  void updating(String id, ItemCard item) {
    var index = items.indexWhere((element) => id == element.id);
    items[index] = item;
  }

  @override
  List<Object> get props => [items];
}

class Deleting extends ItemCardState {
  final List<ItemCard> items;
  const Deleting(this.items);
  void deleting(String id, ItemCard item) {
    items.remove(item);
  }

  @override
  List<Object> get props => [items];
}

class Updatings extends ItemCardState {
  final List<ItemCard> items;
  const Updatings(this.items);

  @override
  List<Object> get props => [items];
}
