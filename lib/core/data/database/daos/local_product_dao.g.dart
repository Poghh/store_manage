// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'local_product_dao.dart';

// ignore_for_file: type=lint
mixin _$LocalProductDaoMixin on DatabaseAccessor<AppDatabase> {
  $LocalProductsTableTable get localProductsTable =>
      attachedDatabase.localProductsTable;
  LocalProductDaoManager get managers => LocalProductDaoManager(this);
}

class LocalProductDaoManager {
  final _$LocalProductDaoMixin _db;
  LocalProductDaoManager(this._db);
  $$LocalProductsTableTableTableManager get localProductsTable =>
      $$LocalProductsTableTableTableManager(
        _db.attachedDatabase,
        _db.localProductsTable,
      );
}
