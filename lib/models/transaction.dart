import 'package:drift/drift.dart';

class Transations extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text().withLength(max: 128)();
  IntColumn get category_id =>
      integer().customConstraint('REFERENCES kategori(id)')();
  DateTimeColumn get transactions_date => dateTime()();
  IntColumn get amount => integer()();
  DateTimeColumn get createdAt => dateTime()();
  DateTimeColumn get updateedAt => dateTime()();
  DateTimeColumn get deleteddAt => dateTime().nullable()();
}
