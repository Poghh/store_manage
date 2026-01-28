import 'package:drift/drift.dart';

class InventoryAdjustmentsTable extends Table {
  TextColumn get productCode => text()();
  IntColumn get adjustment => integer().withDefault(const Constant(0))();

  @override
  Set<Column> get primaryKey => {productCode};
}
