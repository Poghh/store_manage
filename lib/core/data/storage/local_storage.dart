import 'package:encrypted_shared_preferences/encrypted_shared_preferences.dart';

abstract class LocalStorage {
  Future<void> write(String key, String value);
  Future<String?> read(String key);
  Future<void> remove(String key);
  Future<void> clear();
  Future<bool> contains(String key);
}

class LocalStorageImpl implements LocalStorage {
  final EncryptedSharedPreferences _preferences = EncryptedSharedPreferences();

  @override
  Future<void> write(String key, String value) async {
    await _preferences.setString(key, value);
  }

  @override
  Future<String?> read(String key) async {
    try {
      return await _preferences.getString(key);
    } catch (e) {
      return null;
    }
  }

  @override
  Future<void> remove(String key) async {
    await _preferences.remove(key);
  }

  @override
  Future<void> clear() async {
    await _preferences.clear();
  }

  @override
  Future<bool> contains(String key) async {
    try {
      await _preferences.getString(key);
      return true;
    } catch (e) {
      return false;
    }
  }
}
