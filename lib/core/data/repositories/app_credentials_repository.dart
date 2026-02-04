import 'package:store_manage/core/constants/app_endpoints.dart';
import 'package:store_manage/core/network/network_client.dart';

class AppCredentialsRepository {
  final NetworkClient _client;

  AppCredentialsRepository(this._client);

  Future<Map<String, dynamic>> requestAppSecret({required String phone}) async {
    final response = await _client.invoke<Map<String, dynamic>>(
      AppEndpoints.APP_CREDENTIALS,
      RequestType.post,
      requestBody: {'phone': phone, 'appName': 'StoreManage'},
      fromJsonT: (json) => (json as Map<String, dynamic>?) ?? <String, dynamic>{},
    );

    return response.data;
  }
}
