import 'package:drift/drift.dart';

import '../interfaces/local_product_storage.dart';
import '../../database/app_database.dart';
import '../../database/daos/local_product_dao.dart';

class DriftLocalProductStorage implements LocalProductStorage {
  final LocalProductDao _dao;

  DriftLocalProductStorage(this._dao);

  @override
  Future<void> addProduct(Map<String, dynamic> payload) async {
    final companion = _mapToCompanion(payload);
    await _dao.insertProduct(companion);
  }

  @override
  Future<List<Map<String, dynamic>>> getAll() async {
    final products = await _dao.getAllProducts();
    return products.map(_dataToMap).toList();
  }

  @override
  Future<void> upsertProduct(Map<String, dynamic> payload) async {
    await _dao.upsertProduct(_mapToCompanion(payload));
  }

  @override
  Future<Map<String, dynamic>?> getByCode(String productCode) async {
    final product = await _dao.getByCode(productCode);
    return product != null ? _dataToMap(product) : null;
  }

  @override
  Future<void> deleteProduct(String productCode) async {
    await _dao.softDeleteByCode(productCode);
  }

  @override
  Future<void> updateProductCode(String tempCode, String newCode) async {
    await _dao.updateProductCode(tempCode, newCode);
  }

  LocalProductsTableCompanion _mapToCompanion(Map<String, dynamic> payload) {
    return LocalProductsTableCompanion(
      productCode: Value(payload['productCode']?.toString() ?? ''),
      productName: Value(payload['productName']?.toString() ?? ''),
      unit: Value(payload['unit']?.toString()),
      quantity: Value(payload['quantity'] as int? ?? 0),
      purchasePrice: Value(payload['purchasePrice'] as int? ?? 0),
      stockInDate: Value(payload['stockInDate']?.toString()),
      image: Value(payload['image']?.toString()),
      category: Value(payload['category']?.toString()),
      platform: Value(payload['platform']?.toString()),
      brand: Value(payload['brand']?.toString()),
      isDeleted: Value(payload['_deleted'] as bool? ?? false),
      offlineTempCode: Value(payload['_offlineTempCode']?.toString()),
    );
  }

  Map<String, dynamic> _dataToMap(LocalProductsTableData data) {
    return {
      'productCode': data.productCode,
      'productName': data.productName,
      'unit': data.unit,
      'quantity': data.quantity,
      'purchasePrice': data.purchasePrice,
      'stockInDate': data.stockInDate,
      'image': data.image,
      'category': data.category,
      'platform': data.platform,
      'brand': data.brand,
      '_deleted': data.isDeleted,
      '_offlineTempCode': data.offlineTempCode,
      '_syncedAt': data.syncedAt?.toIso8601String(),
    };
  }
}
