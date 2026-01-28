import 'package:drift/drift.dart';

import '../app_database.dart';
import '../tables/local_products_table.dart';

part 'local_product_dao.g.dart';

@DriftAccessor(tables: [LocalProductsTable])
class LocalProductDao extends DatabaseAccessor<AppDatabase>
    with _$LocalProductDaoMixin {
  LocalProductDao(super.db);

  Future<int> insertProduct(LocalProductsTableCompanion product) {
    return into(localProductsTable).insert(product);
  }

  Future<List<LocalProductsTableData>> getAllProducts() {
    return (select(localProductsTable)
          ..where((t) => t.isDeleted.equals(false)))
        .get();
  }

  Future<LocalProductsTableData?> getByCode(String productCode) {
    return (select(localProductsTable)
          ..where((t) =>
              t.productCode.equals(productCode) & t.isDeleted.equals(false)))
        .getSingleOrNull();
  }

  Future<void> upsertProduct(LocalProductsTableCompanion product) async {
    await into(localProductsTable).insertOnConflictUpdate(product);
  }

  Future<void> softDeleteByCode(String productCode) async {
    await (update(localProductsTable)
          ..where((t) => t.productCode.equals(productCode)))
        .write(const LocalProductsTableCompanion(isDeleted: Value(true)));
  }

  Future<void> updateProductCode(String oldCode, String newCode) async {
    await (update(localProductsTable)
          ..where((t) => t.productCode.equals(oldCode)))
        .write(LocalProductsTableCompanion(
          productCode: Value(newCode),
          offlineTempCode: const Value(null),
        ));
  }

  Future<List<LocalProductsTableData>> getUnsynced() {
    return (select(localProductsTable)
          ..where((t) => t.syncedAt.isNull() & t.isDeleted.equals(false)))
        .get();
  }

  Future<void> markSynced(String productCode) async {
    await (update(localProductsTable)
          ..where((t) => t.productCode.equals(productCode)))
        .write(LocalProductsTableCompanion(syncedAt: Value(DateTime.now())));
  }
}
