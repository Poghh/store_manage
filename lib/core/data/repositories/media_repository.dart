import 'package:store_manage/core/constants/app_endpoints.dart';
import 'package:store_manage/core/network/network_client.dart';

class MediaRepository {
  final NetworkClient _client;

  MediaRepository(this._client);

  /// Upload file và trả về URL từ server
  /// Returns null nếu upload thất bại
  Future<String?> uploadImage(String filePath) async {
    try {
      final response = await _client.uploadFile<Map<String, dynamic>>(
        AppEndpoints.MEDIA_UPLOAD,
        filePath,
        fromJsonT: (json) => (json as Map<String, dynamic>?) ?? <String, dynamic>{},
      );
      return (response.data['url'] as String?) ?? '';
    } catch (_) {
      return null;
    }
  }
}
