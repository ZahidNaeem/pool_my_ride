import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import 'home.dart';
import 'register_user.dart';

void setupLocator() {
  GetIt.I.registerLazySingleton(() => RegisterUser());
}

void main() {
  setupLocator();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pool My Ride',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomePage(title: 'Pool My Ride Home Page'),
    );
  }
}
