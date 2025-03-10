import '../services/library_manager.dart';

class BorrowController {
  final LibraryManager libraryManager;
  
  BorrowController({required this.libraryManager});
  
  String borrow(String userId, String bookId) {
    try {
      final book = libraryManager.books.firstWhere((b) => b.id == bookId);
      if (book.isBorrowed) {
        return "Sách đã được mượn!";
      }
      final user = libraryManager.users.firstWhere((u) => u.id == userId);
      book.isBorrowed = true;
      user.borrowedBooks.add(book.id);
      libraryManager.updateState(); 
      return "Mượn sách thành công!";
    } catch (e) {
      return "Không tìm thấy sách hoặc người dùng!";
    }
  }
  
}
