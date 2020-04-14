import 'package:flutter/material.dart';

class Miscellaneous {
  static showAlertDialog1Button(BuildContext context, final String title,
      final String message, final String buttonText) {
    // set up the button
    Widget button = FlatButton(
      child: Text(buttonText),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text(title),
      content: Text(message),
      actions: [
        button,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  static showAlertDialog2Buttons(
      BuildContext context,
      final String title,
      final String message,
      final String firstButtonText,
      final String secondButtonText) {
    // set up first button
    final Widget firstButton = FlatButton(
      child: Text(firstButtonText),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );

    // set up second button
    final Widget secondButton = FlatButton(
      child: Text(secondButtonText),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text(title),
      content: Text(message),
      actions: [firstButton, secondButton],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  static showAlertDialogOKButton(
      BuildContext context, final String title, final String message) {
    // set up OK button
    final Widget okButton = FlatButton(
      child: Text('OK'),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text(title),
      content: Text(message),
      actions: [okButton],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  static showAlertDialogOKCancelButtons(
      BuildContext context, final String title, final String message) {
    // set up OK button
    final Widget okButton = FlatButton(
      child: Text('OK'),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );

    // set up Cancel button
    final Widget cancelButton = FlatButton(
      child: Text('Cancel'),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text(title),
      content: Text(message),
      actions: [okButton, cancelButton],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  static showError({final GlobalKey<ScaffoldState> scaffoldKey,
      final String errorMessage, final int duration = 3}) {
    scaffoldKey.currentState.showSnackBar(SnackBar(
      content: new Text(errorMessage),
      duration: new Duration(seconds: duration),
    ));
    return;
  }
}
