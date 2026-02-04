import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:store_manage/core/constants/app_strings.dart';

abstract class SecureStorage {
  Future<void> saveAccessToken(dynamic value);
  Future<String?> getAccessToken();
  Future<bool> hasToken();
  Future<void> saveUserId(dynamic value);
  Future<String?> getUserId();
  Future<void> saveAppSecret(String value);
  Future<String?> getAppSecret();
  Future<void> clearAppSecret();
  Future<void> savePhoneNumber(String phone);
  Future<String?> getSavedPhoneNumber();
  Future<bool> hasValidPhoneNumber();
  Future<void> clearPhoneNumber();
  Future<void> savePin(String pin);
  Future<String?> getPin();
  Future<bool> hasPin();
  Future<void> clearPin();
  Future<void> saveUserName(String name);
  Future<String?> getUserName();
  Future<void> saveStoreName(String name);
  Future<String?> getStoreName();
  Future<void> saveAvatarPath(String path);
  Future<String?> getAvatarPath();
  Future<void> clearAvatarPath();
  Future<bool> hasProfileSetup();
  void removeAll();
  Future<void> removeAllAsync();
}

class SecureStorageImpl implements SecureStorage {
  static const String _phoneNumberKey = 'saved_phone_number';
  static const String _phoneTimestampKey = 'phone_saved_timestamp';
  static const String _pinKey = 'saved_pin';
  static const String _userNameKey = 'user_name';
  static const String _storeNameKey = 'store_name';
  static const String _avatarPathKey = 'avatar_path';
  static const String _appSecretKey = 'app_secret';
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
  Future<void> saveAppSecret(String value) async {
    await secureStorage.write(key: _appSecretKey, value: value);
  }

  @override
  Future<String?> getAppSecret() {
    return secureStorage.read(key: _appSecretKey);
  }

  @override
  Future<void> clearAppSecret() async {
    await secureStorage.delete(key: _appSecretKey);
  }

  @override
  Future<void> savePhoneNumber(String phone) async {
    await secureStorage.write(key: _phoneNumberKey, value: phone);
    await secureStorage.write(key: _phoneTimestampKey, value: DateTime.now().millisecondsSinceEpoch.toString());
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
  Future<void> savePin(String pin) async {
    await secureStorage.write(key: _pinKey, value: pin);
  }

  @override
  Future<String?> getPin() async {
    return secureStorage.read(key: _pinKey);
  }

  @override
  Future<bool> hasPin() async {
    return secureStorage.containsKey(key: _pinKey);
  }

  @override
  Future<void> clearPin() async {
    await secureStorage.delete(key: _pinKey);
  }

  @override
  Future<void> saveUserName(String name) async {
    await secureStorage.write(key: _userNameKey, value: name);
  }

  @override
  Future<String?> getUserName() async {
    return secureStorage.read(key: _userNameKey);
  }

  @override
  Future<void> saveStoreName(String name) async {
    await secureStorage.write(key: _storeNameKey, value: name);
  }

  @override
  Future<String?> getStoreName() async {
    return secureStorage.read(key: _storeNameKey);
  }

  @override
  Future<void> saveAvatarPath(String path) async {
    await secureStorage.write(key: _avatarPathKey, value: path);
  }

  @override
  Future<String?> getAvatarPath() async {
    return secureStorage.read(key: _avatarPathKey);
  }

  @override
  Future<void> clearAvatarPath() async {
    await secureStorage.delete(key: _avatarPathKey);
  }

  @override
  Future<bool> hasProfileSetup() async {
    final userName = await secureStorage.read(key: _userNameKey);
    return userName != null && userName.isNotEmpty;
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
