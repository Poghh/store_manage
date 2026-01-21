import 'package:flutter/foundation.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'package:store_manage/core/storage/inventory_adjustment_storage.dart';

class InventoryAdjustmentService {
  final InventoryAdjustmentStorage _storage;

  InventoryAdjustmentService(this._storage);

  ValueListenable<Box<int>> get listenable => Hive.box<int>('inventory_adjustments').listenable();

  int adjustedQuantity({required String productCode, required int baseQuantity}) {
    final adjustment = _storage.getAdjustment(productCode);
    return (baseQuantity + adjustment).clamp(0, 1 << 30);
  }

  Future<void> applySale(String productCode, int quantity) => _storage.applySale(productCode, quantity);
}
