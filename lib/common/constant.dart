import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class Constant {
  static const ROOT_API = 'http://10.0.2.2:8089/api/';
  static const BOOK_API = ROOT_API + 'books';
  static const FlutterSecureStorage storage = const FlutterSecureStorage();
}
