import 'package:movie_app/feature/bookmark/data/local/database/bookmark_database.dart';

class DatabaseHelper {
  static BookmarkDatabase? _instance;

  static BookmarkDatabase get database {
    _instance ??= BookmarkDatabase();
    return _instance!;
  }

  static void close() {
    _instance?.close();
    _instance = null;
  }
}
