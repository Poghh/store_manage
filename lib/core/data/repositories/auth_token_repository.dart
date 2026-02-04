import 'package:store_manage/core/constants/app_endpoints.dart';
import 'package:store_manage/core/data/storage/secure_storage.dart';
import 'package:store_manage/core/network/network_client.dart';

class AuthTokenRepository {
  final NetworkClient _client;
  final SecureStorageImpl _secureStorage;

  AuthTokenRepository(this._client, this._secureStorage);

  Future<Map<String, dynamic>> requestToken({required String phone}) async {
    final appSecret = await _secureStorage.getAppSecret() ?? '';
    if (appSecret.trim().isEmpty) {
      return <String, dynamic>{};
    }

    final response = await _client.invoke<Map<String, dynamic>>(
      AppEndpoints.AUTH_TOKEN,
      RequestType.post,
      requestBody: {'appSecret': appSecret, 'phone': phone},
      fromJsonT: (json) => (json as Map<String, dynamic>?) ?? <String, dynamic>{},
    );

    return response.data;
  }
}
