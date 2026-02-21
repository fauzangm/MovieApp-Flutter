import 'package:mobx/mobx.dart';
import 'package:movie_app/feature/movie/data/remote/model/MovieResponse.dart';
import 'package:movie_app/feature/bookmark/data/service/bookmark_service.dart';
import 'package:movie_app/feature/bookmark/data/local/database/bookmark_database.dart';
import 'package:rxdart/rxdart.dart';

part 'bookmark_vm.g.dart';

class BookmarkVM = _BookmarkVM with _$BookmarkVM;

// Global instance to share across screens
final BookmarkVM bookmarkVM = BookmarkVM();

abstract class _BookmarkVM with Store {
  final BookmarkService _service = BookmarkService();

  final BehaviorSubject<List<Bookmark>> _bookmarkSubject =
      BehaviorSubject.seeded([]);

  Stream<List<Bookmark>> get bookmarkStream => _bookmarkSubject.stream;

  final List<Bookmark> _bookmarks = [];

  @observable
  bool isLoading = false;

  @observable
  String? errorMessage;

  @observable
  Set<int> bookmarkedIds = {};

  @action
  Future<void> loadBookmarks() async {
    try {
      isLoading = true;
      errorMessage = null;
      _bookmarks.clear();
      final bookmarks = await _service.getAllBookmarks();
      _bookmarks.addAll(bookmarks);
      
      // Update bookmarked IDs set as observable
      bookmarkedIds.clear();
      bookmarkedIds.addAll(bookmarks.map((b) => b.id));
      
      // Emit copy supaya stream detect change
      _bookmarkSubject.add(List.from(_bookmarks));
    } catch (e) {
      errorMessage = e.toString();
    } finally {
      isLoading = false;
    }
  }

  @action
  Future<void> toggleBookmark(Movie movie) async {
    try {
      // Update bookmarked IDs immediately for UI reactivity
      if (bookmarkedIds.contains(movie.id)) {
        bookmarkedIds.remove(movie.id);
      } else {
        bookmarkedIds.add(movie.id);
      }
      
      await _service.toggleBookmark(movie);
      
      // Update bookmarks list without resetting bookmarkedIds
      final bookmarks = await _service.getAllBookmarks();
      _bookmarks.clear();
      _bookmarks.addAll(bookmarks);
      _bookmarkSubject.add(List.from(_bookmarks));
    } catch (e) {
      errorMessage = e.toString();
      // Revert bookmarkedIds on error
      if (bookmarkedIds.contains(movie.id)) {
        bookmarkedIds.remove(movie.id);
      } else {
        bookmarkedIds.add(movie.id);
      }
    }
  }

  @action
  Future<bool> isBookmarked(int movieId) async {
    return await _service.isBookmarked(movieId);
  }

  void dispose() {
    _bookmarkSubject.close();
  }
}
