import 'package:store_manage/core/constants/app_endpoints.dart';
import 'package:store_manage/core/network/network_client.dart';
import 'package:store_manage/feature/stock_in/data/models/stock_in_product.dart';

abstract class StockInRepository {
  Future<void> submitStockIn(Map<String, dynamic> payload);
  Future<List<StockInProduct>> searchProducts(String query);
}

class StockInRepositoryImpl implements StockInRepository {
  final NetworkClient _client;

  StockInRepositoryImpl(this._client);

  @override
  Future<void> submitStockIn(Map<String, dynamic> payload) async {
    await _client.invoke<Map<String, dynamic>>(
      AppEndpoints.STOCK_IN,
      RequestType.post,
      requestBody: payload,
      fromJsonT: (json) => (json as Map<String, dynamic>?) ?? <String, dynamic>{},
    );
  }

  @override
  Future<List<StockInProduct>> searchProducts(String query) async {
    final response = await _client.invoke<List<StockInProduct>>(
      AppEndpoints.PRODUCT_SEARCH,
      RequestType.get,
      queryParameters: {'q': query},
      fromJsonT: (json) {
        final list = json is List ? json : const <dynamic>[];
        return list.whereType<Map<String, dynamic>>().map(StockInProduct.fromJson).toList();
      },
    );

    return response.data;
  }
}
