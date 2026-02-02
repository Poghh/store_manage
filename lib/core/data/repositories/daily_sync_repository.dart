import 'package:store_manage/core/constants/app_endpoints.dart';
import 'package:store_manage/core/network/network_client.dart';

class DailySyncRepository {
  final NetworkClient _client;

  DailySyncRepository(this._client);

  Future<Map<String, dynamic>> submitDailySync(Map<String, dynamic> payload) async {
    final response = await _client.invoke<Map<String, dynamic>>(
      AppEndpoints.DAILY_SYNC,
      RequestType.post,
      requestBody: payload,
      fromJsonT: (json) => (json as Map<String, dynamic>?) ?? <String, dynamic>{},
    );
    return response.data;
  }
}
