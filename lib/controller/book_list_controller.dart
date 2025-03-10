import 'package:flutter/material.dart';
import '../services/library_manager.dart';
import '../models/book.dart';

class BookListController {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController authorController = TextEditingController();
  final BuildContext context;
  final LibraryManager libraryManager;

  BookListController({
    required this.context,
    required this.libraryManager,
  });

  void addBook() {
    String title = titleController.text.trim();
    String author = authorController.text.trim();

    if (title.isEmpty || author.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Vui lòng nhập đầy đủ thông tin sách")),
      );
      return;
    }

    String newId = (libraryManager.books.length + 1).toString();
    libraryManager.addBook(Book(id: newId, title: title, author: author));
    titleController.clear();
    authorController.clear();
  }

  void dispose() {
    titleController.dispose();
    authorController.dispose();
  }
}
