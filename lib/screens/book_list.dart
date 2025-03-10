import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/book.dart';
import '../services/library_manager.dart';
import '../widgets/book_item.dart';
import '../controller/book_list_controller.dart';

class BookListScreen extends StatefulWidget {
  const BookListScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _BookListScreenState createState() => _BookListScreenState();
}

class _BookListScreenState extends State<BookListScreen> {
  late BookListController _controller;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Lấy instance của LibraryManager từ Provider
    final libraryManager = Provider.of<LibraryManager>(context, listen: false);
    // Khởi tạo controller (chỉ khởi tạo một lần)
    _controller = BookListController(context: context, libraryManager: libraryManager);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final libraryManager = Provider.of<LibraryManager>(context);

    final Color primaryColor = const Color(0xffE60023);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          "Danh sách sách",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold, 
          ),),
        backgroundColor: primaryColor,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Input form được bao bọc trong Card để tạo hiệu ứng nổi
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0),
              ),
              elevation: 4,
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  children: [
                    TextField(
                      controller: _controller.titleController,
                      decoration: InputDecoration(
                        labelText: "Tên Sách",
                        labelStyle: TextStyle(color: primaryColor),
                        border: const OutlineInputBorder(),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: primaryColor, width: 2.0),
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    TextField(
                      controller: _controller.authorController,
                      decoration: InputDecoration(
                        labelText: "Tác giả",
                        labelStyle: TextStyle(color: primaryColor),
                        border: const OutlineInputBorder(),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: primaryColor, width: 2.0),
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () => _controller.addBook,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: primaryColor,
                          padding: const EdgeInsets.symmetric(vertical: 16.0),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                        ),
                        child: const Text(
                          "Thêm Sách",
                          style: TextStyle(fontSize: 16, color: Colors.white),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            // Hiển thị danh sách sách
            Expanded(
              child: libraryManager.books.isEmpty
                  ? Center(
                      child: Text(
                        "Chưa có sách nào",
                        style: TextStyle(color: primaryColor, fontSize: 16),
                      ),
                    )
                  : ListView.builder(
                      itemCount: libraryManager.books.length,
                      itemBuilder: (context, index) {
                        Book book = libraryManager.books[index];
                        return BookItem(book: book);
                      },
                    ),
            ),
          ],
        ),
      ),
    );

  }
}
