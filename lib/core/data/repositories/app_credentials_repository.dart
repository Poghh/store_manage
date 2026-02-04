import 'package:store_manage/core/constants/app_endpoints.dart';
import 'package:store_manage/core/network/network_client.dart';

class AppCredentialsRepository {
  final NetworkClient _client;

  AppCredentialsRepository(this._client);

  Future<Map<String, dynamic>> requestAppSecret({
    required String phone,
    required String storeName,
    required String userName,
  }) async {
    final response = await _client.invoke<Map<String, dynamic>>(
      AppEndpoints.STORE_CREATE_INFORMATION,
      RequestType.post,
      requestBody: {
        'phone': phone,
        'appName': AppEndpoints.STORE_NAME,
        'storeName': storeName,
        'userName': userName,
      },
      fromJsonT: (json) => (json as Map<String, dynamic>?) ?? <String, dynamic>{},
    );

    return response.data;
  }

  /// Check if phone number already exists on server
  /// Returns true if account exists, false otherwise
  Future<bool> checkPhoneExists({required String phone}) async {
    try {
      final response = await _client.invoke<Map<String, dynamic>>(
        AppEndpoints.APP_CREDENTIALS_EXISTS(phone),
        RequestType.get,
        fromJsonT: (json) => (json as Map<String, dynamic>?) ?? <String, dynamic>{},
      );

      // response.data đã là {exists: true/false} (CommonResponseModel tự extract 'data' field)
      return response.data['exists'] == true;
    } catch (e) {
      // Nếu có lỗi (network error, etc), throw để caller xử lý
      rethrow;
    }
  }

  /// Get app secret for existing user
  /// Returns appSecret string or null if not found
  Future<String?> getAppSecret({required String phone}) async {
    try {
      final response = await _client.invoke<Map<String, dynamic>>(
        AppEndpoints.APP_CREDENTIALS_SECRET(phone),
        RequestType.get,
        fromJsonT: (json) => (json as Map<String, dynamic>?) ?? <String, dynamic>{},
      );

      // response.data đã là {appSecret: "..."} (CommonResponseModel tự extract 'data' field)
      return response.data['appSecret'] as String?;
    } catch (e) {
      return null;
    }
  }
}
