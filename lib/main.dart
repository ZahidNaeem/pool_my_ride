import 'package:flutter/material.dart';

import 'home.dart';

void setupLocator() {
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
