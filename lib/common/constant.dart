import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class Constant {
  static const API_BASE_URL = 'http://10.0.2.2:8089/api/';
  static const API_LOGIN_URL = API_BASE_URL + 'auth/signin/';
  static const API_SIGNUP_URL = API_BASE_URL + 'auth/signup/';
  static const API_CURRENT_USER_URL = API_BASE_URL + 'user/me/';
  static const API_CHANGE_PASSWORD_URL = API_BASE_URL + 'user/changePassword/';
  static const API_BOOK_URL = API_BASE_URL + 'books/';
  static const FlutterSecureStorage storage = const FlutterSecureStorage();
}
