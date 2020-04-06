import 'package:flutter/material.dart';
import 'package:poolmyride/service/register_user.dart';

import 'book_delete.dart';
import 'model/api_response.dart';
import 'model/book.dart';

class CarOwner extends StatefulWidget {
  @override
  _CarOwnerState createState() => _CarOwnerState();
}

class _CarOwnerState extends State<CarOwner> {
  bool _isLoading = false;
  List<Book> books = [];
  APIResponse<List<Book>> _apiResponse;

  @override
  void initState() {
    _fetchBooks();
    super.initState();
  }

  _fetchBooks() async {
    setState(() {
      _isLoading = true;
    });
    _apiResponse = await RegisterUser.getAllBooks();
    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('List of notes')),
        body: Builder(builder: (_) {
          if (_isLoading) {
            return Center(child: CircularProgressIndicator());
          }

          if (_apiResponse.error) {
            return Center(child: Text(_apiResponse.errorMessage));
          }

          return ListView.separated(
            separatorBuilder: (_, __) =>
                Divider(height: 1, color: Colors.green),
            itemBuilder: (_, index) {
              return Dismissible(
                key: ValueKey(_apiResponse.data[index].bookId),
                direction: DismissDirection.startToEnd,
                onDismissed: (direction) {},
                confirmDismiss: (direction) async {
                  final result = await showDialog(
                      context: context, builder: (_) => BookDelete());
                  print(result);
                  return result;
                },
                background: Container(
                  color: Colors.red,
                  padding: EdgeInsets.only(left: 16),
                  child: Align(
                    child: Icon(Icons.delete, color: Colors.white),
                    alignment: Alignment.centerLeft,
                  ),
                ),
                child: ListTile(
                  title: Text(
                    _apiResponse.data[index].bookName,
                    style: TextStyle(color: Theme.of(context).primaryColor),
                  ),
                ),
              );
            },
            itemCount: _apiResponse.data.length,
          );
        }));
  }
}
