import 'package:drift/drift.dart';

class OfflineQueueTable extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get queueKey => text()();
  TextColumn get payload => text()();
  DateTimeColumn get createdAt =>
      dateTime().clientDefault(() => DateTime.now())();
  DateTimeColumn get syncedAt => dateTime().nullable()();
}
