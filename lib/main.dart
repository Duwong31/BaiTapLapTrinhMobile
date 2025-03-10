import 'package:flutter/material.dart';
import 'screens/home.dart';
import 'package:provider/provider.dart';
import 'services/library_manager.dart';
void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => LibraryManager(),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title:"Hệ thống Quản lý Thư viện",
      home: HomeScreen(),
    );
  }
}
