import 'package:store_manage/core/constants/app_endpoints.dart';
import 'package:store_manage/core/network/network_client.dart';

class StoreRepository {
  final NetworkClient _client;

  StoreRepository(this._client);

  /// Sync store data to server
  Future<Map<String, dynamic>> syncStore({
    required String phone,
    required DateTime syncTime,
    required String syncData,
  }) async {
    final response = await _client.invoke<Map<String, dynamic>>(
      AppEndpoints.STORE_SYNC,
      RequestType.post,
      requestBody: {
        'phone': phone,
        'syncTime': syncTime.toIso8601String(),
        'syncData': syncData,
      },
      fromJsonT: (json) => (json as Map<String, dynamic>?) ?? <String, dynamic>{},
    );

    return response.data;
  }
}
