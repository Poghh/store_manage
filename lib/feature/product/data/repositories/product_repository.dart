import 'package:store_manage/core/constants/app_endpoints.dart';
import 'package:store_manage/core/network/network_client.dart';
import 'package:store_manage/core/data/services/inventory_adjustment_service.dart';
import 'package:store_manage/core/data/storage/interfaces/local_product_storage.dart';
import 'package:store_manage/feature/product/data/models/product.dart';

abstract class ProductRepository {
  Future<List<Product>> searchProducts(String query);
}

class ProductRepositoryImpl implements ProductRepository {
  final NetworkClient _client;
  final InventoryAdjustmentService _inventoryService;
  final LocalProductStorage _localStorage;

  ProductRepositoryImpl(this._client, this._inventoryService, this._localStorage);

  @override
  Future<List<Product>> searchProducts(String query) async {
    List<Product> items = [];

    try {
      final response = await _client.invoke<List<Product>>(
        AppEndpoints.PRODUCT_SEARCH,
        RequestType.get,
        queryParameters: {'q': query},
        fromJsonT: (json) {
          final list = json is List ? json : const <dynamic>[];
          return list.whereType<Map<String, dynamic>>().map(Product.fromJson).toList();
        },
      );
      items = response.data;
    } catch (_) {
      // If API fails (offline or error), continue with empty server items
      items = [];
    }
    final deletedCodes = <String>{};
    final localItems = <Product>[];
    final localData = await _localStorage.getAll();
    for (final json in localData) {
      if (json['_deleted'] == true) {
        final code = (json['productCode'] ?? '').toString();
        if (code.isNotEmpty) {
          deletedCodes.add(code);
        }
        continue;
      }
      final normalized = <String, dynamic>{
        'productCode': (json['productCode'] ?? '').toString(),
        'productName': (json['productName'] ?? '').toString(),
        'unit': json['unit'],
        'image': json['image'],
        'category': json['category'],
        'platform': json['platform'],
        'brand': json['brand'],
        'quantity': (json['quantity'] is int) ? json['quantity'] as int : int.tryParse('${json['quantity']}') ?? 0,
        'purchasePrice': (json['purchasePrice'] is int)
            ? json['purchasePrice'] as int
            : int.tryParse('${json['purchasePrice']}') ?? 0,
        'stockInDate': (json['stockInDate'] ?? '').toString(),
      };
      localItems.add(Product.fromJson(normalized));
    }

    final mergedMap = <String, Product>{for (final item in items) item.productCode: item};
    for (final local in localItems) {
      mergedMap[local.productCode] = local;
    }
    for (final code in deletedCodes) {
      mergedMap.remove(code);
    }
    var merged = mergedMap.values.toList();
    if (query.trim().isNotEmpty) {
      final keyword = query.trim().toLowerCase();
      merged = merged
          .where(
            (product) =>
                product.productCode.toLowerCase().contains(keyword) ||
                product.productName.toLowerCase().contains(keyword),
          )
          .toList();
    }

    if (merged.isEmpty) return merged;

    final result = <Product>[];
    for (final product in merged) {
      final baseQuantity = product.quantity ?? 0;
      final updatedQuantity = await _inventoryService.adjustedQuantity(
        productCode: product.productCode,
        baseQuantity: baseQuantity,
      );
      result.add(product.copyWith(quantity: updatedQuantity));
    }
    return result;
  }
}
