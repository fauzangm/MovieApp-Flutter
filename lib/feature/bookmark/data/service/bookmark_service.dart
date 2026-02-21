import 'package:drift/drift.dart';
import 'package:movie_app/feature/movie/data/remote/model/MovieResponse.dart';
import 'package:movie_app/feature/bookmark/data/local/database/bookmark_database.dart';
import 'package:movie_app/feature/bookmark/data/local/database/database_helper.dart';

class BookmarkService {
  final BookmarkDatabase _database = DatabaseHelper.database;

  Future<void> addBookmark(Movie movie) async {
    final bookmark = BookmarksCompanion.insert(
      id: Value(movie.id),
      title: movie.title,
      posterPath: Value(movie.posterPath),
      backdropPath: Value(movie.backdropPath),
      voteAverage: movie.voteAverage,
      voteCount: movie.voteCount,
      releaseDate: movie.releaseDate,
      overview: movie.overview,
      createdAt: DateTime.now(),
    );
    await _database.into(_database.bookmarks).insert(bookmark);
  }

  Future<void> removeBookmark(int movieId) async {
    await (_database.delete(_database.bookmarks)..where((tbl) => tbl.id.equals(movieId))).go();
  }

  Future<bool> isBookmarked(int movieId) async {
    final bookmark = await (_database.select(_database.bookmarks)..where((tbl) => tbl.id.equals(movieId))).getSingleOrNull();
    return bookmark != null;
  }

  Future<List<Bookmark>> getAllBookmarks() async {
    return await (_database.select(_database.bookmarks)..orderBy([(tbl) => OrderingTerm(expression: tbl.createdAt, mode: OrderingMode.desc)])).get();
  }

  Future<void> toggleBookmark(Movie movie) async {
    final isBookmarked = await this.isBookmarked(movie.id);
    if (isBookmarked) {
      await removeBookmark(movie.id);
    } else {
      await addBookmark(movie);
    }
  }
}
