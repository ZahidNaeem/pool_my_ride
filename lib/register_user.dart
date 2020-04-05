import 'dart:convert';

import 'package:poolmyride/model/api_response.dart';
import 'package:http/http.dart' as http;
import 'package:poolmyride/model/book.dart';

class RegisterUser {
  static const API = 'http://10.0.2.2:8089/api/';
  static const headers = {
    'Authorization':
        'Bearer eyJhbGciOiJIUzUxMiJ9.eyJzdWIiOiJ6YWhpZCIsImlhdCI6MTU3NzE5Nzc2Mn0.b9HV4HYEpXHq8xki7vIuZwH0BprVTlK9e0rLJfCJhBUztJDG8gRyoZvNBf-XWnekb33lqp7NeJwzZhWOV9So3g'
  };

   Future<APIResponse<List<Book>>> getAllBooks() async {
     var client = http.Client();
    try {
      final data = await client.get(API + 'books', headers: headers);
      if (data.statusCode == 200) {
        final jsonData = json.decode(data.body);
        final books = <Book>[];
        for (var item in jsonData['entity']) {
          final book = Book(bookId: item['bookId'], bookName: item['bookName']);
          books.add(book);
        }
        return APIResponse<List<Book>>(data: books);
      }
      return APIResponse<List<Book>>(
          error: true, errorMessage: 'An error occured');
    } catch (e) {
      return APIResponse<List<Book>>(
          error: true, errorMessage: e.toString());
    }
  }
}
