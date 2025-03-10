import '../services/library_manager.dart';

class ReturnController {
  final LibraryManager libraryManager;
  
  ReturnController({required this.libraryManager});

  String returnBook(String userId, String bookId) {
    try {
      final book = libraryManager.books.firstWhere((b) => b.id == bookId);
      final user = libraryManager.users.firstWhere((u) => u.id == userId);
      
      if (!book.isBorrowed) {
        return "Sách chưa được mượn!";
      }
      if (!user.borrowedBooks.contains(book.id)) {
        return "Người dùng không mượn sách này!";
      }
      
      book.isBorrowed = false;
      user.borrowedBooks.remove(book.id);
      libraryManager.updateState();
      return "Trả sách thành công!";
    } catch (e) {
      return "Không tìm thấy sách hoặc người dùng!";
    }
  }
}
