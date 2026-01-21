import 'package:store_manage/core/constants/app_endpoints.dart';
import 'package:store_manage/core/network/network_client.dart';

abstract class RetailRepository {
  Future<void> submitRetailSale(Map<String, dynamic> payload);
}

class RetailRepositoryImpl implements RetailRepository {
  final NetworkClient _client;

  RetailRepositoryImpl(this._client);

  @override
  Future<void> submitRetailSale(Map<String, dynamic> payload) async {
    await _client.invoke<Map<String, dynamic>>(
      AppEndpoints.RETAIL_SALE,
      RequestType.post,
      requestBody: payload,
      fromJsonT: (json) => (json as Map<String, dynamic>?) ?? <String, dynamic>{},
    );
  }
}
