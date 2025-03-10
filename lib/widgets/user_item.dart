import 'package:flutter/material.dart';
import '../models/user.dart';

class UserItem extends StatelessWidget {
  final User user;
  const UserItem({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(user.name),
    );
  }
}
