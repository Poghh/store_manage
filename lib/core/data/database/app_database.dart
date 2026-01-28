import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';

import 'tables/local_products_table.dart';
import 'tables/retail_transactions_table.dart';
import 'tables/inventory_adjustments_table.dart';
import 'tables/offline_queue_table.dart';
import 'tables/app_state_table.dart';

part 'app_database.g.dart';

@DriftDatabase(tables: [
  LocalProductsTable,
  RetailTransactionsTable,
  InventoryAdjustmentsTable,
  OfflineQueueTable,
  AppStateTable,
])
class AppDatabase extends _$AppDatabase {
  AppDatabase([QueryExecutor? executor]) : super(executor ?? _openConnection());

  @override
  int get schemaVersion => 2;

  @override
  MigrationStrategy get migration => MigrationStrategy(
        onUpgrade: (migrator, from, to) async {
          if (from < 2) {
            await migrator.addColumn(localProductsTable, localProductsTable.syncedAt);
            await migrator.addColumn(retailTransactionsTable, retailTransactionsTable.syncedAt);
            await migrator.addColumn(offlineQueueTable, offlineQueueTable.syncedAt);
          }
        },
      );

  static QueryExecutor _openConnection() {
    return driftDatabase(name: 'store_manage_db');
  }

  /// Clears all data from storage tables (products, transactions, adjustments, queue).
  /// Does NOT clear app_state table (used for fresh install detection).
  Future<void> clearAllStorageData() async {
    await delete(localProductsTable).go();
    await delete(retailTransactionsTable).go();
    await delete(inventoryAdjustmentsTable).go();
    await delete(offlineQueueTable).go();
  }
}
