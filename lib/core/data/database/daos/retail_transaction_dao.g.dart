// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'retail_transaction_dao.dart';

// ignore_for_file: type=lint
mixin _$RetailTransactionDaoMixin on DatabaseAccessor<AppDatabase> {
  $RetailTransactionsTableTable get retailTransactionsTable =>
      attachedDatabase.retailTransactionsTable;
  RetailTransactionDaoManager get managers => RetailTransactionDaoManager(this);
}

class RetailTransactionDaoManager {
  final _$RetailTransactionDaoMixin _db;
  RetailTransactionDaoManager(this._db);
  $$RetailTransactionsTableTableTableManager get retailTransactionsTable =>
      $$RetailTransactionsTableTableTableManager(
        _db.attachedDatabase,
        _db.retailTransactionsTable,
      );
}
