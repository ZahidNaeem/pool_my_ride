import 'package:flutter/material.dart';
import 'package:poolmyride/controller/auth_controller.dart';
import 'package:poolmyride/model/api_response.dart';
import 'package:poolmyride/model/login_request.dart';
import 'package:poolmyride/util/miscellaneous.dart';
import 'package:poolmyride/views/home.dart';

class Login extends StatefulWidget {
  Login({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  bool _obscureText = true;

  void _toggleObscureText() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  @override
  void dispose() {
    usernameController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  /*void _showcontent(final String message) {
    showDialog<Null>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return new AlertDialog(
          title: new Text('Login Status'),
          content: new SingleChildScrollView(
            child: new ListBody(
              children: <Widget>[
                new Text(message),
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
  }*/

  void _submitValue() async {
    if (usernameController.text.isEmpty) {
      Miscellaneous.showError(
          scaffoldKey: _scaffoldKey, errorMessage: 'Username is empty');
    } else if (passwordController.text.isEmpty) {
      Miscellaneous.showError(
          scaffoldKey: _scaffoldKey, errorMessage: 'Password is empty');
    } else {
      final LoginRequest loginRequest = new LoginRequest(
          usernameOrEmail: usernameController.text,
          password: passwordController.text);
      final APIResponse response = await AuthController.login(loginRequest);
      print(response.toString());
      Miscellaneous.showAlertDialogOKButton(
          context, 'Login Status', response.message);
//    _showcontent(response.message);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Container(
        width: double.infinity,
        padding: EdgeInsets.all(12),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextFormField(
              controller: usernameController,
              decoration: InputDecoration(hintText: 'enter username'),
              validator: (val) => val.length < 6 ? 'Username too short.' : null,
            ),
            TextFormField(
              keyboardType: TextInputType.visiblePassword,
              controller: passwordController,
              decoration: InputDecoration(hintText: 'enter password'),
              obscureText: _obscureText,
              validator: (val) => val.length < 6 ? 'Password too short.' : null,
            ),
            FlatButton(
              onPressed: _toggleObscureText,
              child: Text(_obscureText ? 'Show' : 'Hide'),
            ),
            Divider(),
            RaisedButton(
              child: Text('Submit'),
              color: Colors.indigo,
              textColor: Colors.white,
              onPressed: _submitValue,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text('Not Registered? '),
                FlatButton(
                  child: new Text('Register'),
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (_) => HomePage(title: 'a')));
                  },
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
