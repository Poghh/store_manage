abstract class InventoryAdjustmentStorage {
  Future<int> getAdjustment(String productCode);
  Future<void> applySale(String productCode, int quantity);
  Future<void> applyStockIn(String productCode, int quantity);
  Future<void> setAdjustment(String productCode, int value);
}
