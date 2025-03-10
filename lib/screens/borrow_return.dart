import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../services/library_manager.dart';
import '../controller/borrow.dart';
import '../controller/return.dart';

class BorrowReturnScreen extends StatefulWidget {
  const BorrowReturnScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _BorrowReturnScreenState createState() => _BorrowReturnScreenState();
}

class _BorrowReturnScreenState extends State<BorrowReturnScreen> {
  String? selectedUserId;
  String? selectedBookId;
  String resultMessage = '';

  late BorrowController borrowController;
  late ReturnController returnController;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final libraryManager =
        Provider.of<LibraryManager>(context, listen: false);
    borrowController = BorrowController(libraryManager: libraryManager);
    returnController = ReturnController(libraryManager: libraryManager);

    if (selectedUserId == null && libraryManager.users.isNotEmpty) {
      selectedUserId = libraryManager.users.first.id;
    }
    if (selectedBookId == null && libraryManager.books.isNotEmpty) {
      selectedBookId = libraryManager.books.first.id;
    }
  }

  void _handleBorrow() {
    if (selectedUserId == null || selectedBookId == null) return;
    String result = borrowController.borrow(selectedUserId!, selectedBookId!);
    setState(() {
      resultMessage = result;
    });
  }

  void _handleReturn() {
    if (selectedUserId == null || selectedBookId == null) return;
    String result = returnController.returnBook(selectedUserId!, selectedBookId!);
    setState(() {
      resultMessage = result;
    });
  }

  @override
  Widget build(BuildContext context) {
    final libraryManager = Provider.of<LibraryManager>(context);

    final Color primaryColor = const Color(0xffE60023);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text("Hệ Thống Quản Lý Thư Viện", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        backgroundColor: primaryColor,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              // Bao bọc dropdown trong Card để tạo hiệu ứng nổi
              Card(
                elevation: 4,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    children: [
                      // Dropdown chọn người dùng
                      DropdownButtonFormField<String>(
                        value: selectedUserId,
                        decoration: InputDecoration(
                          labelText: "Chọn Người Dùng",
                          labelStyle: TextStyle(color: primaryColor),
                          border: const OutlineInputBorder(),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: primaryColor, width: 2.0),
                          ),
                        ),
                        items: libraryManager.users.map((user) {
                          return DropdownMenuItem<String>(
                            value: user.id,
                            child: Text(user.name),
                          );
                        }).toList(),
                        onChanged: (value) {
                          setState(() {
                            selectedUserId = value;
                          });
                        },
                      ),
                      const SizedBox(height: 16),
                      // Dropdown chọn sách
                      DropdownButtonFormField<String>(
                        value: selectedBookId,
                        decoration: InputDecoration(
                          labelText: "Chọn Sách",
                          labelStyle: TextStyle(color: primaryColor),
                          border: const OutlineInputBorder(),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: primaryColor, width: 2.0),
                          ),
                        ),
                        items: libraryManager.books.map((book) {
                          return DropdownMenuItem<String>(
                            value: book.id,
                            child: Text(book.title),
                          );
                        }).toList(),
                        onChanged: (value) {
                          setState(() {
                            selectedBookId = value;
                          });
                        },
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),
              // Nút mượn và trả sách
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: _handleBorrow,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: primaryColor,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: const Text(
                        "Mượn Sách",
                        style: TextStyle(fontSize: 16, color: Colors.white),
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: _handleReturn,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: primaryColor,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: const Text(
                        "Trả Sách",
                        style: TextStyle(fontSize: 16, color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              // Hiển thị thông báo kết quả
              Text(
                resultMessage,
                style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black87),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
