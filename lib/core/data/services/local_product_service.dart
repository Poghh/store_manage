import 'package:store_manage/core/data/storage/interfaces/local_product_storage.dart';

class LocalProductService {
  final LocalProductStorage _storage;

  LocalProductService(this._storage);

  Future<void> addFromStockInPayload(Map<String, dynamic> payload) {
    return _storage.addProduct(payload);
  }

  Future<void> updateProductCode(String tempCode, String newCode) {
    return _storage.updateProductCode(tempCode, newCode);
  }

  Future<void> upsertProduct(Map<String, dynamic> payload) {
    return _storage.upsertProduct(payload);
  }

  Future<Map<String, dynamic>?> getByCode(String productCode) => _storage.getByCode(productCode);

  Future<List<Map<String, dynamic>>> getAll() => _storage.getAll();

  Future<void> deleteProduct(String productCode) => _storage.deleteProduct(productCode);
}
