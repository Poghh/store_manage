import 'package:store_manage/core/constants/app_endpoints.dart';
import 'package:store_manage/core/network/network_client.dart';
import 'package:store_manage/core/services/inventory_adjustment_service.dart';
import 'package:store_manage/feature/product/data/models/product.dart';

abstract class ProductRepository {
  Future<List<Product>> searchProducts(String query);
}

class ProductRepositoryImpl implements ProductRepository {
  final NetworkClient _client;
  final InventoryAdjustmentService _inventoryService;

  ProductRepositoryImpl(this._client, this._inventoryService);

  @override
  Future<List<Product>> searchProducts(String query) async {
    final response = await _client.invoke<List<Product>>(
      AppEndpoints.PRODUCT_SEARCH,
      RequestType.get,
      queryParameters: {'q': query},
      fromJsonT: (json) {
        final list = json is List ? json : const <dynamic>[];
        return list.whereType<Map<String, dynamic>>().map(Product.fromJson).toList();
      },
    );

    final items = response.data;
    if (items.isEmpty) return items;

    return items.map((product) {
      final baseQuantity = product.quantity ?? 0;
      final updatedQuantity = _inventoryService.adjustedQuantity(
        productCode: product.productCode,
        baseQuantity: baseQuantity,
      );
      return product.copyWith(quantity: updatedQuantity);
    }).toList();
  }
}
