import 'package:flutter/material.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import 'providers/item_list_bloc_provider.dart';

// Data, state, and event classes.

void main() {
  WidgetsFlutterBinding.ensureInitialized(); //هاد السطر جنن سماي للقيتو
  //Future<FirebaseApp> _initialization = Firebase.initializeApp();
  runApp(
    App(),
  );
}

class App extends StatelessWidget {
  // Create the initilization Future outside of `build`:
  Future<FirebaseApp> _initialization = Firebase.initializeApp();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      // Initialize FlutterFire:
      future: _initialization,
      builder: (context, snapshot) {
        // Check for errors
        if (snapshot.hasError) {
          return Scaffold(
            appBar: AppBar(
              title: Text('Error'),
            ),
            body: Container(
              child: Text('SomethingWentWrong'),
            ),
          );
        }

        // Once complete, show your application
        if (snapshot.connectionState == ConnectionState.done) {
          return ItemListProvider();
        }

        // Otherwise, show something whilst waiting for initialization to complete
        return SpinKitRotatingCircle(color: Colors.green);
      },
    );
  }
}
