import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_form_bloc/flutter_form_bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:i18n_extension/i18n_extension.dart';
import 'package:shop_0_1/item_repo_general.dart';

import '../../handler/item_handler.dart';
import '../../models/itemCard.dart';

class AllFieldsFormBloc extends FormBloc<String, String> {
  ItemsHandler itemsHandler;

  final brandTF = TextFieldBloc();
  final modelTF = TextFieldBloc();
  final spec1Tf = TextFieldBloc();
  final spec2Tf = TextFieldBloc();
  final spec3Tf = TextFieldBloc();

  final sellPriceTF = TextFieldBloc();
  final buyPriceTF = TextFieldBloc();

  final startQuantTF = TextFieldBloc();
  final startQuantPriceTF = TextFieldBloc();

  final barcodeTF = TextFieldBloc();

  CollectionReference itemsRef = FirebaseFirestore.instance.collection('items');

  AllFieldsFormBloc() {
    addFieldBlocs(fieldBlocs: [
      brandTF,
      modelTF,
      sellPriceTF,
      buyPriceTF,
      spec1Tf,
      spec2Tf,
      spec3Tf,
      startQuantTF,
      startQuantPriceTF,
      barcodeTF,
    ]);
  }
  ItemsRepository itemsRepo;
  @override
  void onSubmitting() async {
    //TODO build this function
    try {
      print('#############################');
      ItemCard item;
      item.copyWith(
          barcode: barcodeTF.value,
          brand: brandTF.value,
          buyPrice: buyPriceTF.valueToDouble,
          model: modelTF.value,
          sellPrice: sellPriceTF.valueToDouble,
          specefication: [spec1Tf.value, spec2Tf.value, spec3Tf.value],
          startQuantity: startQuantTF.valueToInt,
          startQuantityPrice: startQuantPriceTF.valueToDouble);
      itemsRepo.addNewItem(item);
      print('11111111111111111111111111111111111');
      /* itemsHandler.addItem(
          brandTF.value.toString().trim(),
          modelTF.value.toString().trim(),
          [
            spec1Tf.value.toString().trim(),
            spec2Tf.value.toString().trim(),
            spec3Tf.value.toString().trim()
          ],
          double.parse(sellPriceTF.value.toString().trim()),
          double.parse(buyPriceTF.value.toString().trim()),
          barcodeTF.value.toString().trim(),
          int.parse(startQuantTF.value.toString().trim()),
          double.parse(startQuantPriceTF.value.toString().trim())); */

      //print(brandTF.value.toString().trim());
      /* itemsRef
          .add({
            'brand': brandTF.value.toString().trim(),
            'model': modelTF.value.toString().trim(),
            'buyPrice': double.parse(buyPriceTF.value.toString().trim()),
            'sellPrice': double.parse(sellPriceTF.value.toString().trim()),
            'barcode': barcodeTF.value.toString().trim(),
            'quanitityBalance': int.parse(startQuantTF.value.toString().trim()),
            'specefication': [
              spec1Tf.value.toString().trim(),
              spec2Tf.value.toString().trim(),
              spec3Tf.value.toString().trim()
            ],
            'startQuantity': int.parse(startQuantTF.value.toString().trim()),
            'startQuantityPrice':
                double.parse(startQuantPriceTF.value.toString().trim()),
          })
          .then((value) => print('Item Added'))
          .catchError((erroe) => print('Faild adding Item')); */
      print('#############################');

      //await Future<void>.delayed(Duration(milliseconds: 5));
      emitSuccess(canSubmitAgain: true);
    } catch (e) {
      emitFailure();
    }
  }
}

class AllFieldsForm extends StatelessWidget {
  static const routeName = 'form';
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AllFieldsFormBloc(),
      child: Builder(
        builder: (context) {
          final formBloc = BlocProvider.of<AllFieldsFormBloc>(context);

          return Theme(
            data: Theme.of(context).copyWith(
              inputDecorationTheme: InputDecorationTheme(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
            ),
            child: Scaffold(
              appBar: AppBar(title: Text('Add item form')),
              body: FormBlocListener<AllFieldsFormBloc, String, String>(
                onSubmitting: (context, state) {
                  LoadingDialog.show(context);
                },
                onSuccess: (context, state) {
                  LoadingDialog.hide(context);

                  Navigator.of(context).pushReplacement(
                      MaterialPageRoute(builder: (_) => SuccessScreen()));
                },
                onFailure: (context, state) {
                  LoadingDialog.hide(context);

                  Scaffold.of(context).showSnackBar(
                      SnackBar(content: Text(state.failureResponse)));
                },
                child: SingleChildScrollView(
                  physics: ClampingScrollPhysics(),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: <Widget>[
                        Row(
                          children: [
                            Expanded(
                              child: TextFieldBlocBuilder(
                                textFieldBloc: formBloc.brandTF,
                                decoration: InputDecoration(
                                  labelText: 'Brand',
                                  prefixIcon: Icon(Icons.text_fields),
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Expanded(
                              child: TextFieldBlocBuilder(
                                textFieldBloc: formBloc.modelTF,
                                decoration: InputDecoration(
                                  labelText: 'Model',
                                  prefixIcon: Icon(Icons.text_fields),
                                ),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: TextFieldBlocBuilder(
                                textFieldBloc: formBloc.spec1Tf,
                                decoration: InputDecoration(
                                  labelText: 'Spec 1',
                                  prefixIcon: Icon(Icons.details),
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Expanded(
                              child: TextFieldBlocBuilder(
                                textFieldBloc: formBloc.spec2Tf,
                                decoration: InputDecoration(
                                  labelText: 'Spec 2',
                                  prefixIcon: Icon(
                                    Icons.details,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Expanded(
                              child: TextFieldBlocBuilder(
                                textFieldBloc: formBloc.spec3Tf,
                                decoration: InputDecoration(
                                  labelText: 'Spec 3',
                                  prefixIcon: Icon(Icons.details),
                                ),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: TextFieldBlocBuilder(
                                textFieldBloc: formBloc.buyPriceTF,
                                decoration: InputDecoration(
                                  labelText: 'Buy Price',
                                  prefixIcon: Icon(Icons.monetization_on),
                                ),
                                keyboardType: TextInputType.number,
                              ),
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Expanded(
                              child: TextFieldBlocBuilder(
                                textFieldBloc: formBloc.sellPriceTF,
                                decoration: InputDecoration(
                                  labelText: 'Sell Price',
                                  prefixIcon: Icon(Icons.monetization_on),
                                ),
                                keyboardType: TextInputType.number,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: TextFieldBlocBuilder(
                                textFieldBloc: formBloc.startQuantTF,
                                decoration: InputDecoration(
                                  labelText: 'Start Quantity',
                                  prefixIcon: Icon(Icons.archive),
                                ),
                                keyboardType: TextInputType.number,
                              ),
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Expanded(
                              child: TextFieldBlocBuilder(
                                textFieldBloc: formBloc.startQuantPriceTF,
                                decoration: InputDecoration(
                                  labelText: 'Start Quantity Unit price',
                                  prefixIcon: Icon(Icons.monetization_on),
                                ),
                                keyboardType: TextInputType.number,
                              ),
                            ),
                          ],
                        ),
                        TextFieldBlocBuilder(
                          textFieldBloc: formBloc.barcodeTF,
                          decoration: InputDecoration(
                            labelText: 'Barcode',
                            prefixIcon: Icon(Icons.qr_code),
                          ),
                          keyboardType: TextInputType.number,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              floatingActionButton: FloatingActionButton(
                onPressed: () {
                  formBloc.submit();
                },
                child: Icon(Icons.send_and_archive),
              ),
            ),
          );
        },
      ),
    );
  }
}

class LoadingDialog extends StatelessWidget {
  static void show(BuildContext context, {Key key}) => showDialog<void>(
        context: context,
        useRootNavigator: false,
        barrierDismissible: false,
        builder: (_) => LoadingDialog(key: key),
      ).then((_) => FocusScope.of(context).requestFocus(FocusNode()));

  static void hide(BuildContext context) => Navigator.pop(context);

  LoadingDialog({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Center(
        child: Card(
          child: Container(
            width: 80,
            height: 80,
            padding: EdgeInsets.all(12.0),
            child: CircularProgressIndicator(),
          ),
        ),
      ),
    );
  }
}

class SuccessScreen extends StatelessWidget {
  SuccessScreen({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(Icons.tag_faces, size: 100),
            SizedBox(height: 10),
            Text(
              'Success',
              style: TextStyle(fontSize: 54, color: Colors.black),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 10),
            RaisedButton.icon(
              onPressed: () => Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (_) => AllFieldsForm())),
              icon: Icon(Icons.replay),
              label: Text('AGAIN'),
            ),
          ],
        ),
      ),
    );
  }
}
