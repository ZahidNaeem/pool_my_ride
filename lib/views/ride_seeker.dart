import 'package:flutter/material.dart';
import 'package:poolmyride/service/register_user.dart';

class RideSeeker extends StatefulWidget {
  @override
  _RideSeekerState createState() => _RideSeekerState();
}

class _RideSeekerState extends State<RideSeeker> {
  final bookIdController = TextEditingController();
  final bookNameController = TextEditingController();

  @override
  void dispose() {
    bookIdController.dispose();
    super.dispose();
  }

  void submitValue() async {
    await RegisterUser.registerBook(
        bookId: int.parse(bookIdController.text),
        bookName: bookNameController.text);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Ride Seeker'),
        ),
        body: Container(
          padding: const EdgeInsets.all(16.0),
          width: double.infinity,
          child: Column(
            children: <Widget>[
              TextField(
                keyboardType: TextInputType.number,
                controller: bookIdController,
                decoration: InputDecoration(hintText: 'enter book ID'),
              ),
              TextField(
                controller: bookNameController,
                decoration: InputDecoration(hintText: 'enter book Name'),
              ),
              Divider(),
              RaisedButton(
                child: Text('Submit'),
                color: Colors.indigo,
                textColor: Colors.white,
                onPressed: submitValue,
              )
            ],
          ),
        ));
  }
}
