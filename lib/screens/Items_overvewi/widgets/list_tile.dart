import 'package:flutter/material.dart';

import 'package:auto_size_text/auto_size_text.dart';

import 'list_tile.i18n.dart';

import 'package:shop_0_1/models/itemCard.dart';
//import 'package:shop_0_1/screens/add_item_card/edit_item_card_Screen_C2.dart';

class ItemTile extends StatelessWidget {
  final ItemCard itemCard;

  ItemTile(this.itemCard);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(4),
      child: ListTile(
        leading: CircleAvatar(
          backgroundImage: NetworkImage(itemCard.imageUrl),
        ),
        title: Text('${itemCard.brand} ${itemCard.model}'),
        subtitle: Text(
            '${itemCard.specefication[0]}/${itemCard.specefication[1]}/${itemCard.specefication[2]}'),
        trailing: Column(
          children: <Widget>[
            Expanded(
              child: AutoSizeText(
                'Avilabel: %s'
                    .i18n
                    .fill([itemCard.quanitityBalance.toString()]),
                maxFontSize: 15,
                maxLines: 1,
              ),
            ),
            Expanded(
              child: AutoSizeText(
                'Buy: %s \$'.i18n.fill([itemCard.buyPrice.toString()]),
                style: TextStyle(color: Colors.green),
                maxFontSize: 15,
                maxLines: 1,
              ),
            ),
            Expanded(
              child: AutoSizeText(
                'Sell: %s \$'.i18n.fill([itemCard.sellPrice.toString()]),
                style: TextStyle(
                  color: Colors.red,
                ),
                maxFontSize: 15,
                maxLines: 1,
              ),
            ),
          ],
        ),
        onLongPress: () {
          /* 
          Navigator.of(context)
              .pushNamed(EditItemCardScreen.routeName, arguments: itemCard.id);
         */
        },
      ),
    );
  }
}
