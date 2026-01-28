import 'package:drift/drift.dart';

import '../app_database.dart';
import '../tables/retail_transactions_table.dart';

part 'retail_transaction_dao.g.dart';

@DriftAccessor(tables: [RetailTransactionsTable])
class RetailTransactionDao extends DatabaseAccessor<AppDatabase>
    with _$RetailTransactionDaoMixin {
  RetailTransactionDao(super.db);

  Future<int> insertTransaction(RetailTransactionsTableCompanion transaction) {
    return into(retailTransactionsTable).insert(transaction);
  }

  Future<List<RetailTransactionsTableData>> getAllTransactions() {
    return select(retailTransactionsTable).get();
  }

  Future<List<RetailTransactionsTableData>> getTransactionsByDateRange(
    DateTime start,
    DateTime end,
  ) {
    return (select(retailTransactionsTable)
          ..where(
              (t) => t.createdAt.isBiggerOrEqualValue(start) & t.createdAt.isSmallerOrEqualValue(end)))
        .get();
  }

  Future<List<RetailTransactionsTableData>> getUnsynced() {
    return (select(retailTransactionsTable)..where((t) => t.syncedAt.isNull()))
        .get();
  }

  Future<void> markSynced(int id) async {
    await (update(retailTransactionsTable)..where((t) => t.id.equals(id)))
        .write(RetailTransactionsTableCompanion(syncedAt: Value(DateTime.now())));
  }
}
