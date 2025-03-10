import 'package:flutter/material.dart';
import '../models/book.dart';
import '../models/user.dart';

class LibraryManager extends ChangeNotifier {
  List<Book> books = [];
  List<User> users = [];

  LibraryManager() {
    // Khởi tạo dữ liệu mẫu
    books = [
      Book(id: "1", title: "Sự Im Lặng Của Bầy Cừu", author: "Thomas Harris"),
      Book(id: "2", title: "Khúc Tráng Ca Băng Và Lửa", author: "George R.R Martin"),
      Book(id: "3", title: "Trên Đường Băng", author: "Tony buổi sáng"),
    ];

    users = [
      User(id: "1", name: "Lý Triều Dương"),
      User(id: "2", name: "John Cena"),
      User(id: "3", name: "Magneto"),
    ];
  }

  void addBook(Book book) {
    books.add(book);
    notifyListeners();
  }

  void addUser(User user) {
    users.add(user);
    notifyListeners();
  }
   void updateState() {
    notifyListeners();
  }

  String? getBorrowerName(String bookId) {
    for (var user in users) {
      if (user.borrowedBooks.contains(bookId)) {
        return user.name;
      }
    }
    return null;
  }
}
