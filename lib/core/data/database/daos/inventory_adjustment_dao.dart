import 'package:drift/drift.dart';

import '../app_database.dart';
import '../tables/inventory_adjustments_table.dart';

part 'inventory_adjustment_dao.g.dart';

@DriftAccessor(tables: [InventoryAdjustmentsTable])
class InventoryAdjustmentDao extends DatabaseAccessor<AppDatabase>
    with _$InventoryAdjustmentDaoMixin {
  InventoryAdjustmentDao(super.db);

  Future<int> getAdjustment(String productCode) async {
    final result = await (select(inventoryAdjustmentsTable)
          ..where((t) => t.productCode.equals(productCode)))
        .getSingleOrNull();
    return result?.adjustment ?? 0;
  }

  Future<void> setAdjustment(String productCode, int value) async {
    await into(inventoryAdjustmentsTable).insertOnConflictUpdate(
      InventoryAdjustmentsTableCompanion(
        productCode: Value(productCode),
        adjustment: Value(value),
      ),
    );
  }

  Future<void> applyDelta(String productCode, int delta) async {
    final current = await getAdjustment(productCode);
    await setAdjustment(productCode, current + delta);
  }
}
