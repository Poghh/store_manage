import 'package:hive/hive.dart';

abstract class InventoryAdjustmentStorage {
  int getAdjustment(String productCode);
  Future<void> applySale(String productCode, int quantity);
  Future<void> applyStockIn(String productCode, int quantity);
  Future<void> setAdjustment(String productCode, int value);
}

class HiveInventoryAdjustmentStorage implements InventoryAdjustmentStorage {
  final Box<int> _box;

  HiveInventoryAdjustmentStorage(this._box);

  @override
  int getAdjustment(String productCode) {
    return _box.get(productCode, defaultValue: 0) ?? 0;
  }

  @override
  Future<void> applySale(String productCode, int quantity) async {
    if (productCode.isEmpty || quantity <= 0) return;
    final current = getAdjustment(productCode);
    await _box.put(productCode, current - quantity);
  }

  @override
  Future<void> applyStockIn(String productCode, int quantity) async {
    if (productCode.isEmpty || quantity <= 0) return;
    final current = getAdjustment(productCode);
    await _box.put(productCode, current + quantity);
  }

  @override
  Future<void> setAdjustment(String productCode, int value) async {
    if (productCode.isEmpty) return;
    await _box.put(productCode, value);
  }
}
