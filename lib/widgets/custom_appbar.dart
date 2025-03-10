import 'package:flutter/material.dart';

class CustomBottomNavigationBar extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;

  const CustomBottomNavigationBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.house_sharp),
          label: 'Quản lý',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person),
          label: 'Người dùng',
        ),
        
        BottomNavigationBarItem(
          icon: Icon(Icons.menu_book_outlined),
          label: 'Sách',
        ),
      ],
      currentIndex: currentIndex,
      selectedItemColor: Color(0xffE60023),
      onTap: onTap,
    );
  }
}
