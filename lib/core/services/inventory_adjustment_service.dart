import 'package:flutter/foundation.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'package:store_manage/core/storage/inventory_adjustment_storage.dart';

class InventoryAdjustmentService {
  final InventoryAdjustmentStorage _storage;

  InventoryAdjustmentService(this._storage);

  ValueListenable<Box<int>> get listenable => Hive.box<int>('inventory_adjustments').listenable();

  int getAdjustment(String productCode) => _storage.getAdjustment(productCode);

  int adjustedQuantity({required String productCode, required int baseQuantity}) {
    final adjustment = _storage.getAdjustment(productCode);
    return (baseQuantity + adjustment).clamp(0, 1 << 30);
  }

  Future<void> applySale(String productCode, int quantity) => _storage.applySale(productCode, quantity);

  Future<void> applyStockIn(String productCode, int quantity) => _storage.applyStockIn(productCode, quantity);

  Future<void> setAdjustment(String productCode, int value) => _storage.setAdjustment(productCode, value);

  Future<void> migrateProductCode({required String from, required String to}) async {
    if (from.isEmpty || to.isEmpty || from == to) return;

    final value = _storage.getAdjustment(from);
    if (value == 0) return;

    final currentTo = _storage.getAdjustment(to);

    await _storage.setAdjustment(to, currentTo + value);
    await _storage.setAdjustment(from, 0);
  }

}
