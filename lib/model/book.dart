class Book {
  int bookId;
  String bookName;

  Book({this.bookId, this.bookName});

  int get id {
    return bookId;
  }

  set id(int id) {
    this.bookId = id;
  }

  String get name {
    return bookName;
  }

  set name(String name) {
    this.bookName = name;
  }

  factory Book.fromJson(Map<String, dynamic> json) {
    return Book(bookId: json['bookId'], bookName: json['bookName']);
  }

  Map<String, dynamic> toJson() => {'bookId': bookId, 'bookName': bookName};
}
