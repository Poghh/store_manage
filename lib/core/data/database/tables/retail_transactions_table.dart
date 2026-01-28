import 'package:drift/drift.dart';

class RetailTransactionsTable extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get productCode => text()();
  TextColumn get productName => text().nullable()();
  IntColumn get quantity => integer()();
  IntColumn get total => integer()();
  DateTimeColumn get createdAt => dateTime()();
  TextColumn get extraData => text().nullable()();
  DateTimeColumn get syncedAt => dateTime().nullable()();
}
