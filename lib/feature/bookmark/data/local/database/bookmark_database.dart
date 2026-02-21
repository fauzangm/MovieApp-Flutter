import 'dart:io';
import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;
import '../entity/bookmark_entity.dart';

part 'bookmark_database.g.dart';

@DriftDatabase(tables: [Bookmarks])
class BookmarkDatabase extends _$BookmarkDatabase {
  BookmarkDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 1;
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'bookmarks.sqlite'));
    return NativeDatabase(file);
  });
}
