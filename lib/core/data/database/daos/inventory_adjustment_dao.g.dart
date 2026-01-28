// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'inventory_adjustment_dao.dart';

// ignore_for_file: type=lint
mixin _$InventoryAdjustmentDaoMixin on DatabaseAccessor<AppDatabase> {
  $InventoryAdjustmentsTableTable get inventoryAdjustmentsTable =>
      attachedDatabase.inventoryAdjustmentsTable;
  InventoryAdjustmentDaoManager get managers =>
      InventoryAdjustmentDaoManager(this);
}

class InventoryAdjustmentDaoManager {
  final _$InventoryAdjustmentDaoMixin _db;
  InventoryAdjustmentDaoManager(this._db);
  $$InventoryAdjustmentsTableTableTableManager get inventoryAdjustmentsTable =>
      $$InventoryAdjustmentsTableTableTableManager(
        _db.attachedDatabase,
        _db.inventoryAdjustmentsTable,
      );
}
