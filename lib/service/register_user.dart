import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:poolmyride/common/api_utils.dart';
import 'package:poolmyride/common/constant.dart';
import 'package:poolmyride/model/api_response.dart';
import 'package:poolmyride/model/book.dart';

class RegisterUser {

  static Future<APIResponse<List<Book>>> getAllBooks() async {
    final Options options = Options(method: 'GET');
    try {
      var response = await APIUtils.request(path: Constant.API_BOOK_URL, options: options);
      final books = <Book>[];
      for (var item in response.data['entity']) {
        final book = Book(bookId: item['bookId'], bookName: item['bookName']);
        books.add(book);
      }
      return APIResponse<List<Book>>(data: books);
    } catch (e) {
      return APIResponse<List<Book>>(error: true, errorMessage: e.toString());
    }
  }

  static Future<APIResponse<Book>> registerBook(
      {final int bookId, final String bookName}) async {
    print('register book called');
    final Book bookBody = Book(bookName: bookName);
    final Options options = Options(method: 'POST');
    try {
      var response = await APIUtils.request(
          path: Constant.API_BOOK_URL,
          data: json.encode(bookBody.toJson()),
          options: options);
      final book = Book.fromJson(response.data);
      print(book);
      return APIResponse<Book>(data: book);
    } catch (e) {
      print(e.toString());
      return APIResponse<Book>(error: true, errorMessage: e.toString());
    }
  }
}
