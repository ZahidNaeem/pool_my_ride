import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:poolmyride/util/api_utils.dart';
import 'package:poolmyride/util/constant.dart';
import 'package:poolmyride/model/api_response.dart';
import 'package:poolmyride/model/book.dart';

class RegisterUser {

  static Future<APIResponse<List<Book>>> getAllBooks() async {
    final Options options = Options(method: 'GET');
    try {
      var response = await APIUtils.request(path: Constant.API_BOOK_URL, options: options);
      final books = <Book>[];
      for (var item in response.entity['entity']) {
        final book = Book(bookId: item['bookId'], bookName: item['bookName']);
        books.add(book);
      }
      return APIResponse<List<Book>>(entity: books);
    } catch (e) {
      return APIResponse<List<Book>>(success: true, message: e.toString());
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
      final book = Book.fromJson(response.entity);
      print(book);
      return APIResponse<Book>(entity: book);
    } catch (e) {
      print(e.toString());
      return APIResponse<Book>(success: true, message: e.toString());
    }
  }
}
