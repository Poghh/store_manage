import 'package:drift/drift.dart';

class LocalProductsTable extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get productCode => text().unique()();
  TextColumn get productName => text()();
  TextColumn get unit => text().nullable()();
  IntColumn get quantity => integer().withDefault(const Constant(0))();
  IntColumn get purchasePrice => integer().withDefault(const Constant(0))();
  TextColumn get stockInDate => text().nullable()();
  TextColumn get image => text().nullable()();
  TextColumn get category => text().nullable()();
  TextColumn get platform => text().nullable()();
  TextColumn get brand => text().nullable()();
  BoolColumn get isDeleted => boolean().withDefault(const Constant(false))();
  TextColumn get offlineTempCode => text().nullable()();
  DateTimeColumn get createdAt =>
      dateTime().clientDefault(() => DateTime.now())();
  DateTimeColumn get syncedAt => dateTime().nullable()();
}
