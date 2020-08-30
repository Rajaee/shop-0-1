import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../item_repo_general.dart';

import './state/newState.dart';
import '../models/itemCard.dart';

// Just a stub event for example purposes.
// Your actual source bloc would have more logic.

enum _itemEntryEvent { load, add, update, delete, updates }

class _MyEnumContainer {
  _itemEntryEvent get load => _itemEntryEvent.load;
  _itemEntryEvent get add => _itemEntryEvent.add;
  _itemEntryEvent get update => _itemEntryEvent.update;
  _itemEntryEvent get delete => _itemEntryEvent.delete;
  _itemEntryEvent get updates => _itemEntryEvent.updates;
}

class EnumHelper {
  static var _myEnumContainerInstance = _MyEnumContainer();
  static _MyEnumContainer get MyEnum => _myEnumContainerInstance;
}

class ItemCardBloc extends Bloc<_itemEntryEvent, ItemCardState> {
  ItemCardBloc() : super(Loading());

  ItemsRepository _itemRepo;
  FirebaseItemsRepository _fireRebo;
  StreamSubscription _itemSupscription;

/*   ItemCardBloc({@required ItemsRepository itemsRepo})
      : assert(itemsRepo != null),
        _itemRepo = itemsRepo;
 */

  @override
  Stream<ItemCardState> mapEventToState(
    _itemEntryEvent event,
  ) async* {
    if (event == _itemEntryEvent.load) {
      // Stub data for the example, you would likely be using some sort
      // of repository here to fetch your data.
      //yield itemRepo.items();
/*       yield Loaded([
        ItemCard(
            id: '1', //DateTime.now().toString(),
            brand: 'Iphone',
            model: '11',
            sellPrice: 1100,
            buyPrice: 1000,
            imageUrl:
                'https://s2.turkcell.com.tr/SiteAssets/Cihaz/cep-telefonu/apple/11/cg/1.png',
            specefication: ['256 GB', '8 Ram', 'Black'],
            startQuantity: 10,
            startQuantityPrice: 980,
            quanitityBalance:
                10, // TODO if start quantity is not 0, quatity balance should be equal to it.
            barcode: '0001'),
        ItemCard(
            id: '2', //DateTime.now().toString(),
            brand: 'Samsung',
            model: 'S 10 plus',
            sellPrice: 1200,
            buyPrice: 1050,
            imageUrl:
                'https://productimages.hepsiburada.net/s/25/375/10107992703026.jpg',
            specefication: ['256 GB', '4 Ram', 'Red'],
            startQuantity: 5,
            startQuantityPrice: 1050,
            quanitityBalance:
                5, // TODO if start quantity is not 0, quatity balance should be equal to it.
            barcode: '0002'),
      ]); */
      yield* mapItemsToState();
    } else if (event == _itemEntryEvent.add) {
      Adding add;
      yield* _mapAddItemToState(add);
    } else if (event == _itemEntryEvent.update) {
      Updating update;
      yield* _mapUpdateItemToState(update);
    } else if (event == _itemEntryEvent.delete) {
      Deleting delete;
      yield* _mapDeleteItemToState(delete);
    } else if (event == _itemEntryEvent.updates) {
      Updatings udates;
      yield* _mapItemsUpdateToState(udates);
    }
  }

  Stream<ItemCardState> mapItemsToState() async* {
    _itemSupscription?.cancel();
    print('9999999999999999999999999999999');
    _itemSupscription = _fireRebo.items().listen(
      (itemsList) {
        print('XXXXXXXXXXXXXXXXXXXXXXXXXX');
        add(_itemEntryEvent.updates);
      },
    );
/*     List<ItemCard> listA = [];
    Loaded(listA); */
  }

  Stream<ItemCardState> _mapAddItemToState(Adding event) async* {
    _itemRepo.addNewItem(event.items[0]);
  }

  Stream<ItemCardState> _mapUpdateItemToState(Updating event) async* {
    _itemRepo.updateItem(event.items[0]);
  }

  Stream<ItemCardState> _mapDeleteItemToState(Deleting event) async* {
    _itemRepo.deleteItem(event.items[0]);
  }

  Stream<ItemCardState> _mapItemsUpdateToState(Updatings event) async* {
    yield Loaded(event.items);
  }

  @override
  void dispose() {
    _itemSupscription?.cancel();
    //super.drain(); //هون اخترعت لأنو في مشكلة بال dispose().
  }
}
