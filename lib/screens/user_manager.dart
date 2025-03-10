import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../services/library_manager.dart';
import '../models/user.dart';
import '../widgets/user_item.dart';

class UserManagerScreen extends StatefulWidget {
  const UserManagerScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _UserManagerScreenState createState() => _UserManagerScreenState();
}

class _UserManagerScreenState extends State<UserManagerScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();

  void _addUser(LibraryManager libraryManager) {
    String name = _nameController.text.trim();
    if (name.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Vui lòng nhập đầy đủ thông tin người dùng")),
      );
      return;
    }

    String newId = (libraryManager.users.length + 1).toString();
    libraryManager.addUser(User(id: newId, name: name));
    _nameController.clear();
    _ageController.clear();
  }

  @override
  Widget build(BuildContext context) {
    final libraryManager = Provider.of<LibraryManager>(context);

    final Color primaryColor = const Color(0xffE60023);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text("Quản lý người dùng",
        style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold
        ),),
        backgroundColor: primaryColor,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Form nhập thông tin người dùng được bao bọc trong Card
            Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  children: [
                    TextField(
                      controller: _nameController,
                      decoration: InputDecoration(
                        labelText: "Họ và Tên",
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
                        onPressed: () => _addUser(libraryManager),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: primaryColor,
                          padding: const EdgeInsets.symmetric(vertical: 16.0),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                        ),
                        child: const Text(
                          "Thêm Người Dùng",
                          style: TextStyle(fontSize: 16, color: Colors.white),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            // Hiển thị danh sách người dùng
            Expanded(
              child: libraryManager.users.isEmpty
                  ? Center(
                      child: Text(
                        "Chưa có người dùng nào",
                        style: TextStyle(color: primaryColor, fontSize: 16),
                      ),
                    )
                  : ListView.builder(
                      itemCount: libraryManager.users.length,
                      itemBuilder: (context, index) {
                        final user = libraryManager.users[index];
                        return UserItem(user: user);
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
