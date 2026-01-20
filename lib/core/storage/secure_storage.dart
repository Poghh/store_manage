
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:store_manage/core/constants/app_strings.dart';

abstract class SecureStorage {
  Future<void> saveAccessToken(dynamic value);
  Future<String?> getAccessToken();
  Future<bool> hasToken();
  Future<void> saveUserId(dynamic value);
  Future<String?> getUserId();
  void removeAll();
  Future<void> removeAllAsync();
}

class SecureStorageImpl implements SecureStorage {
  /// Define secure storage
  final secureStorage = const FlutterSecureStorage();

  @override
  Future<void> saveAccessToken(dynamic value) async {
    return await secureStorage.write(key: AppStrings.ACCESSTOKEN, value: value);
  }

  @override
  Future<String?> getAccessToken() {
    return secureStorage.read(key: AppStrings.ACCESSTOKEN);
  }

  @override
  Future<bool> hasToken() async {
    bool hasToken = await secureStorage.containsKey(key: AppStrings.ACCESSTOKEN);
    return hasToken;
  }

  @override
  Future<void> saveUserId(dynamic value) async {
    return await secureStorage.write(key: AppStrings.USERID, value: value);
  }

  @override
  Future<String?> getUserId() {
    return secureStorage.read(key: AppStrings.USERID);
  }

  @override
  void removeAll() async {
    await secureStorage.deleteAll();
  }

  @override
  Future<void> removeAllAsync() async {
    await secureStorage.deleteAll();
  }
}
