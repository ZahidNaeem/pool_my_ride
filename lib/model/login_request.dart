import 'package:flutter/cupertino.dart';

class LoginRequest {
  String usernameOrEmail;
  String password;

  LoginRequest({@required this.usernameOrEmail, @required this.password});

  factory LoginRequest.fromJson(Map<String, dynamic> json) {
    return LoginRequest(usernameOrEmail: json['usernameOrEmail'], password: json['password']);
  }

  Map<String, dynamic> toJson() => {'usernameOrEmail': usernameOrEmail, 'password': password};
}
