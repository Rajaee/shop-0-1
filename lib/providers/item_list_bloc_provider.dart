import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter/material.dart';
import 'package:i18n_extension/i18n_widget.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import '../screens/Items_overvewi/items_screen_C1.dart';

import '../bloc/newBloc.dart';
import '../screens/add-item/add_item_screen.dart';

class ItemListProvider extends StatelessWidget {
  const ItemListProvider({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ItemCardBloc>(
      create: (_) => ItemCardBloc()..add(EnumHelper.MyEnum.load),
      child: MaterialApp(
        localizationsDelegates: [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: [
          const Locale('en', "US"),
          const Locale('ar', "AR"),
        ],
        title: 'Shop 01',
        home: I18n(
          child: ItemScreen(),
          //initialLocale: Locale('ar', "AR"),
        ),
        routes: {
          AllFieldsForm.routeName: (ctx) => AllFieldsForm(),
        },
      ),
    );
  }
}
