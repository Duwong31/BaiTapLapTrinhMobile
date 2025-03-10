class Book{
  final String id;
  final String title;
  final String author;
  bool isBorrowed;

  Book({required this.id, required this.title, required this.author, this.isBorrowed = false});
}