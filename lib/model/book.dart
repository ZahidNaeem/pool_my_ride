class Book {
  int bookId;
  String bookName;

  Book({final int bookId, final String bookName}){
    this.bookId = bookId;
    this.bookName = bookName;
  }

  factory Book.fromJson(Map<String, dynamic> json) {
    return Book(bookId: json['bookId'], bookName: json['bookName']);
  }

  Map<String, dynamic> toJson() => {'bookId': bookId, 'bookName': bookName};
}
