class User {
  final String id;
  final String name;
  List<String> borrowedBooks; // id book

  User({
    required this.id, 
    required this.name, 
    List<String>? borrowedBooks,
  }) : borrowedBooks = borrowedBooks ?? [];
}
