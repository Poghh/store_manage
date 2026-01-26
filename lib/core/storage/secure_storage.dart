import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:store_manage/core/constants/app_strings.dart';

abstract class SecureStorage {
  Future<void> saveAccessToken(dynamic value);
  Future<String?> getAccessToken();
  Future<bool> hasToken();
  Future<void> saveUserId(dynamic value);
  Future<String?> getUserId();
  Future<void> savePhoneNumber(String phone);
  Future<String?> getSavedPhoneNumber();
  Future<bool> hasValidPhoneNumber();
  Future<void> clearPhoneNumber();
  void removeAll();
  Future<void> removeAllAsync();
}

class SecureStorageImpl implements SecureStorage {
  static const String _phoneNumberKey = 'saved_phone_number';
  static const String _phoneTimestampKey = 'phone_saved_timestamp';
  static const int _expirationDays = 30;

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
  Future<void> savePhoneNumber(String phone) async {
    await secureStorage.write(key: _phoneNumberKey, value: phone);
    await secureStorage.write(
      key: _phoneTimestampKey,
      value: DateTime.now().millisecondsSinceEpoch.toString(),
    );
  }

  @override
  Future<String?> getSavedPhoneNumber() async {
    if (!await hasValidPhoneNumber()) {
      return null;
    }
    return secureStorage.read(key: _phoneNumberKey);
  }

  @override
  Future<bool> hasValidPhoneNumber() async {
    final phone = await secureStorage.read(key: _phoneNumberKey);
    final timestampStr = await secureStorage.read(key: _phoneTimestampKey);

    if (phone == null || timestampStr == null) {
      return false;
    }

    final timestamp = int.tryParse(timestampStr);
    if (timestamp == null) {
      return false;
    }

    final savedDate = DateTime.fromMillisecondsSinceEpoch(timestamp);
    final expirationDate = savedDate.add(Duration(days: _expirationDays));

    if (DateTime.now().isAfter(expirationDate)) {
      await clearPhoneNumber();
      return false;
    }

    return true;
  }

  @override
  Future<void> clearPhoneNumber() async {
    await secureStorage.delete(key: _phoneNumberKey);
    await secureStorage.delete(key: _phoneTimestampKey);
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
