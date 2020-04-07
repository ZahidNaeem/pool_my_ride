import 'package:flutter/material.dart';
import 'package:poolmyride/views/login.dart';

void main() {
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
      // home: HomePage(title: 'Pool My Ride Home Page'),
      home: Login(title: 'Pool My Ride Home Page'),
    );
  }
}
