import '../interfaces/inventory_adjustment_storage.dart';
import '../../database/daos/inventory_adjustment_dao.dart';

class DriftInventoryAdjustmentStorage implements InventoryAdjustmentStorage {
  final InventoryAdjustmentDao _dao;

  DriftInventoryAdjustmentStorage(this._dao);

  @override
  Future<int> getAdjustment(String productCode) async {
    return _dao.getAdjustment(productCode);
  }

  @override
  Future<void> applySale(String productCode, int quantity) async {
    if (productCode.isEmpty || quantity <= 0) return;
    await _dao.applyDelta(productCode, -quantity);
  }

  @override
  Future<void> applyStockIn(String productCode, int quantity) async {
    if (productCode.isEmpty || quantity <= 0) return;
    await _dao.applyDelta(productCode, quantity);
  }

  @override
  Future<void> setAdjustment(String productCode, int value) async {
    if (productCode.isEmpty) return;
    await _dao.setAdjustment(productCode, value);
  }
}
