import 'package:flutter_bloc_list_manager/flutter_bloc_list_manager.dart';
import 'package:flutter/material.dart';
import 'package:shop_0_1/screens/add-item/add_item_screen.dart';
import '../../models/itemCard.dart';
import '../../bloc/state/newState.dart';
import '../../bloc/newBloc.dart';
import 'widgets/list_search.dart';
import 'widgets/list_filiter.dart';
import 'widgets/list_render.dart';

class ItemScreen extends StatelessWidget {
  //Future<FirebaseApp> _initialization = Firebase.initializeApp();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Item Card List C1'),
        actions: [
          IconButton(
              icon: Icon(Icons.add),
              onPressed: () {
                Navigator.of(context).pushNamed(AllFieldsForm.routeName);
              })
        ],
      ),
      body: ListManager<ItemCard, Loaded, ItemCardBloc>(
        filterProperties: [
          'brand'
        ], //TODO filter based on quantity balance (avilabel, not avilabel)
        searchProperties: ['brand', 'model', 'barcode'],
        child: Column(
          children: [
            Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SearchInput(),
                FilterConditionsLauncher(),
              ],
            ),
            SizedBox(height: 10.0),
            Expanded(
              child: ItemListRenderer(),
            ),
          ],
        ),
      ),
    );
  }
}
