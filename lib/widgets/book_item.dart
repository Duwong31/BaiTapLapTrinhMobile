import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/book.dart';
import '../services/library_manager.dart';

class BookItem extends StatelessWidget {
  final Book book;
  const BookItem({super.key, required this.book});

  @override
  Widget build(BuildContext context) {
    final libraryManager = Provider.of<LibraryManager>(context);
    String? borrowerName = libraryManager.getBorrowerName(book.id);

    return ListTile(
      title: Text(book.title, style: TextStyle(fontWeight: FontWeight.bold ),),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Tác giả: ${book.author}"),
          if (book.isBorrowed && borrowerName != null)
            Text(
              "Được mượn bởi: $borrowerName",
              style: TextStyle(color: Colors.green),
            ),
        ],
      ),
      trailing: Icon(
        book.isBorrowed ? Icons.check_circle : Icons.cancel,
        color: book.isBorrowed ? Colors.blue[700] : Colors.red,
      ),
    );
  }
}
