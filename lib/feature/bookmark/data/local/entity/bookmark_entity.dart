import 'package:drift/drift.dart';

class Bookmarks extends Table {
  IntColumn get id => integer()();
  TextColumn get title => text()();
  TextColumn get posterPath => text().nullable()();
  TextColumn get backdropPath => text().nullable()();
  RealColumn get voteAverage => real()();
  IntColumn get voteCount => integer()();
  TextColumn get releaseDate => text()();
  TextColumn get overview => text()();
  DateTimeColumn get createdAt => dateTime()();

  @override
  Set<Column> get primaryKey => {id};
}
