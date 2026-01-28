abstract class LocalProductStorage {
  Future<void> addProduct(Map<String, dynamic> payload);
  Future<List<Map<String, dynamic>>> getAll();
  Future<void> updateProductCode(String tempCode, String newCode);
  Future<void> upsertProduct(Map<String, dynamic> payload);
  Future<Map<String, dynamic>?> getByCode(String productCode);
  Future<void> deleteProduct(String productCode);
}
