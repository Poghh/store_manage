import 'package:store_manage/core/data/repositories/app_credentials_repository.dart';
import 'package:store_manage/core/data/repositories/auth_token_repository.dart';
import 'package:store_manage/core/data/storage/secure_storage.dart';

class AuthTokenService {
  final AppCredentialsRepository _appCredentialsRepository;
  final AuthTokenRepository _repository;
  final SecureStorageImpl _secureStorage;

  AuthTokenService(this._appCredentialsRepository, this._repository, this._secureStorage);

  /// Kiểm tra credentials local còn hợp lệ không
  Future<bool> hasValidCredentials() async {
    final appSecret = await _secureStorage.getAppSecret();
    if (appSecret == null || appSecret.isEmpty) return false;
    return _secureStorage.isTokenValid();
  }

  /// Đảm bảo có credentials hợp lệ, chỉ gọi API khi cần
  Future<void> ensureValidCredentials({required String phone}) async {
    if (phone.trim().isEmpty) return;
    try {
      final appSecret = await _secureStorage.getAppSecret();
      final tokenValid = await _secureStorage.isTokenValid();

      if (appSecret != null && appSecret.isNotEmpty && tokenValid) {
        // Đã có đủ credentials hợp lệ → không cần gọi API
        return;
      }

      if (appSecret == null || appSecret.isEmpty) {
        // Chưa có appSecret → lấy từ server
        final secret = await _appCredentialsRepository.getAppSecret(phone: phone);
        if (secret != null && secret.isNotEmpty) {
          await _secureStorage.saveAppSecret(secret);
        }
      }

      if (!tokenValid) {
        // Token hết hạn hoặc chưa có → lấy mới
        await requestAndSaveToken(phone: phone);
      }
    } catch (_) {}
  }

  /// Gọi API lấy token cho user đã có account
  Future<void> requestAppSecretAndToken({required String phone, required String pin}) async {
    if (phone.trim().isEmpty || pin.trim().isEmpty) return;
    await ensureValidCredentials(phone: phone);
  }

  /// Tạo credentials mới và lấy token cho user mới
  Future<void> createCredentialsAndGetToken({
    required String phone,
    required String storeName,
    required String userName,
  }) async {
    if (phone.trim().isEmpty) return;
    try {
      final data = await _appCredentialsRepository.requestAppSecret(
        phone: phone,
        storeName: storeName,
        userName: userName,
      );
      final secret = _extractAppSecret(data);
      if (secret != null && secret.isNotEmpty) {
        await _secureStorage.saveAppSecret(secret);
      }
      await requestAndSaveToken(phone: phone);
    } catch (_) {}
  }

  Future<void> requestAndSaveToken({required String phone}) async {
    if (phone.trim().isEmpty) return;
    try {
      final data = await _repository.requestToken(phone: phone);
      final token = _extractToken(data);
      if (token != null && token.isNotEmpty) {
        await _secureStorage.saveAccessToken(token);
      }

      final expiresAt = _readString(data, ['expiresAt']) ??
          _readString(data['data'] is Map<String, dynamic> ? data['data'] : {}, ['expiresAt']);
      if (expiresAt != null && expiresAt.isNotEmpty) {
        await _secureStorage.saveTokenExpiry(expiresAt);
      }

      final userId = _extractUserId(data);
      if (userId != null && userId.isNotEmpty) {
        await _secureStorage.saveUserId(userId);
      }
    } catch (_) {}
  }

  String? _extractAppSecret(Map<String, dynamic> data) {
    final direct = _readString(data, ['appSecret', 'secret']);
    if (direct != null) return direct;

    final nested = data['data'];
    if (nested is Map<String, dynamic>) {
      return _readString(nested, ['appSecret', 'secret']);
    }
    return null;
  }

  String? _extractToken(Map<String, dynamic> data) {
    final direct = _readString(data, ['accessToken', 'token', 'jwt']);
    if (direct != null) return direct;

    final nested = data['data'];
    if (nested is Map<String, dynamic>) {
      return _readString(nested, ['accessToken', 'token', 'jwt']);
    }
    return null;
  }

  String? _extractUserId(Map<String, dynamic> data) {
    final direct = _readString(data, ['userId', 'id']);
    if (direct != null) return direct;

    final nested = data['data'];
    if (nested is Map<String, dynamic>) {
      return _readString(nested, ['userId', 'id']);
    }
    return null;
  }

  String? _readString(Map<String, dynamic> data, List<String> keys) {
    for (final key in keys) {
      final value = data[key];
      if (value == null) continue;
      final text = value.toString().trim();
      if (text.isNotEmpty) return text;
    }
    return null;
  }
}
