import 'package:flutter/material.dart';

import 'car_owner.dart';
import 'ride_seeker.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
                width: double.infinity,
                child: Text(
                  'Welcome to our application\nPlease select one of below choices to begins:',
                  style: TextStyle(fontSize: 18),
                  textAlign: TextAlign.center,
                )),
            Container(
              width: double.infinity,
              child: RaisedButton(
                color: Colors.blue,
                textColor: Colors.white,
                child: Text('Register as Ride Seeker'),
                onPressed: () => Navigator.of(context)
                    .push(MaterialPageRoute(builder: (_) => RideSeeker())),
              ),
            ),
            Container(
              width: double.infinity,
              child: RaisedButton(
                color: Colors.blue,
                textColor: Colors.white,
                child: Text('Register as Car Owner'),
                onPressed: () => Navigator.of(context)
                    .push(MaterialPageRoute(builder: (_) => CarOwner())),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
