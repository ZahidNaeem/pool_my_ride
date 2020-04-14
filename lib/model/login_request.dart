import 'package:flutter/cupertino.dart';

class LoginRequest {
  String usernameOrEmail;
  String password;

  LoginRequest({@required this.usernameOrEmail, @required this.password});

  LoginRequest.fromJson(Map<String, dynamic> json)
      : usernameOrEmail = json['usernameOrEmail'],
        password = json['password'];

  Map<String, dynamic> toJson() =>
      {'usernameOrEmail': usernameOrEmail, 'password': password};
}
