import 'package:flutter/material.dart';
import 'package:poolmyride/common/api_utils.dart';
import 'package:poolmyride/model/login_request.dart';

class Login extends StatefulWidget {
  Login({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void dispose() {
    usernameController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  void _showcontent() {
    showDialog<Null>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return new AlertDialog(
          title: new Text('You clicked on'),
          content: new SingleChildScrollView(
            child: new ListBody(
              children: <Widget>[
                new Text('This is a Dialog Box. Click OK to Close.'),
              ],
            ),
          ),
          actions: <Widget>[
            new FlatButton(
              child: new Text('Ok'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void submitValue() async {
    final LoginRequest loginRequest = new LoginRequest(
        username: usernameController.text, password: passwordController.text);
    await APIUtils.login(loginRequest);
    _showcontent();
  }

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
            TextField(
              controller: usernameController,
              decoration: InputDecoration(hintText: 'enter username'),
            ),
            TextField(
              keyboardType: TextInputType.visiblePassword,
              controller: passwordController,
              decoration: InputDecoration(hintText: 'enter password'),
            ),
            Divider(),
            RaisedButton(
              child: Text('Submit'),
              color: Colors.indigo,
              textColor: Colors.white,
              onPressed: submitValue,
            ),
          ],
        ),
      ),
    );
  }
}
