import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_list_manager/flutter_bloc_list_manager.dart';
import 'package:flutter/material.dart';

import '../../../models/itemCard.dart';
import './list_tile.dart';

// Hooks into the state from the `ItemListBloc` and renders the list
// portion of the UI.
class ItemListRenderer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ItemListBloc, ItemListState>(
      builder: (ctx, state) {
        if (state is NoSourceItems) {
          return Text('No source items');
        }

        if (state is ItemEmptyState) {
          return Text('No matching results');
        }

        if (state is ItemResults<ItemCard>) {
          return ListView.builder(
            itemBuilder: (context, index) => ItemTile(state.items[index]),
            itemCount: state.items.length,
          );
        }

        return Container();
      },
    );
  }
}
