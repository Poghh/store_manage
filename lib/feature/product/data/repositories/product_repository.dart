import 'package:store_manage/core/constants/app_endpoints.dart';
import 'package:store_manage/core/network/network_client.dart';
import 'package:store_manage/feature/product/data/models/product.dart';

abstract class ProductRepository {
  Future<List<Product>> searchProducts(String query);
}

class ProductRepositoryImpl implements ProductRepository {
  final NetworkClient _client;

  ProductRepositoryImpl(this._client);

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

    return response.data;
  }
}
