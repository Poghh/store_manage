import 'package:flutter/foundation.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'package:store_manage/core/storage/local_product_storage.dart';

class LocalProductService {
  final LocalProductStorage _storage;

  LocalProductService(this._storage);

  ValueListenable<Box<List<String>>> get listenable => Hive.box<List<String>>('local_products').listenable();

  Future<void> addFromStockInPayload(Map<String, dynamic> payload) {
    return _storage.addProduct(payload);
  }

  Future<void> updateProductCode(String tempCode, String newCode) {
    return _storage.updateProductCode(tempCode, newCode);
  }

  Future<void> upsertProduct(Map<String, dynamic> payload) {
    return _storage.upsertProduct(payload);
  }

  Map<String, dynamic>? getByCode(String productCode) => _storage.getByCode(productCode);

  List<Map<String, dynamic>> getAll() => _storage.getAll();

  Future<void> deleteProduct(String productCode) => _storage.deleteProduct(productCode);
}
