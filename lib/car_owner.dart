import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:poolmyride/book_delete.dart';
import 'package:poolmyride/model/book.dart';
import 'package:poolmyride/model/api_response.dart';
import 'package:poolmyride/register_user.dart';

class CarOwner extends StatefulWidget {
  @override
  _CarOwnerState createState() => _CarOwnerState();
}

class _CarOwnerState extends State<CarOwner> {
  bool _isLoading = false;
  List<Book> books = [];
  APIResponse<List<Book>> _apiResponse;
  RegisterUser get service => GetIt.I<RegisterUser>();

  @override
  void initState() {
    _fetchBooks();
    super.initState();
  }

  _fetchBooks() async {
    setState(() {
      _isLoading = true;
    });
    _apiResponse = await service.getAllBooks();
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
