import 'dart:convert';

import 'package:hive/hive.dart';

abstract class LocalProductStorage {
  Future<void> addProduct(Map<String, dynamic> payload);
  List<Map<String, dynamic>> getAll();
  Future<void> updateProductCode(String tempCode, String newCode);
  Future<void> upsertProduct(Map<String, dynamic> payload);
  Map<String, dynamic>? getByCode(String productCode);
  Future<void> deleteProduct(String productCode);
}

class HiveLocalProductStorage implements LocalProductStorage {
  static const String _key = 'local_products';
  final Box<List<String>> _box;

  HiveLocalProductStorage(this._box);

  @override
  Future<void> addProduct(Map<String, dynamic> payload) async {
    final items = _box.get(_key, defaultValue: <String>[]) ?? <String>[];
    items.add(jsonEncode(payload));
    await _box.put(_key, items);
  }

  @override
  List<Map<String, dynamic>> getAll() {
    final items = _box.get(_key, defaultValue: <String>[]) ?? <String>[];
    return items.map((item) => jsonDecode(item) as Map<String, dynamic>).toList();
  }

  @override
  Future<void> upsertProduct(Map<String, dynamic> payload) async {
    final code = (payload['productCode'] ?? '').toString();
    if (code.isEmpty) return;
    final items = _box.get(_key, defaultValue: <String>[]) ?? <String>[];
    var updated = false;
    final next = items.map((item) {
      final map = jsonDecode(item) as Map<String, dynamic>;
      if ((map['productCode'] ?? '').toString() == code) {
        updated = true;
        return jsonEncode(payload);
      }
      return item;
    }).toList();
    if (!updated) {
      next.add(jsonEncode(payload));
    }
    await _box.put(_key, next);
  }

  @override
  Map<String, dynamic>? getByCode(String productCode) {
    final code = productCode.trim();
    if (code.isEmpty) return null;
    final items = _box.get(_key, defaultValue: <String>[]) ?? <String>[];
    for (final item in items) {
      final map = jsonDecode(item) as Map<String, dynamic>;
      final isDeleted = map['_deleted'] == true;
      if ((map['productCode'] ?? '').toString() == code && !isDeleted) {
        return map;
      }
    }
    return null;
  }

  @override
  Future<void> deleteProduct(String productCode) async {
    final code = productCode.trim();
    if (code.isEmpty) return;
    final items = _box.get(_key, defaultValue: <String>[]) ?? <String>[];
    var alreadyDeleted = false;
    final next = <String>[];
    for (final item in items) {
      final map = jsonDecode(item) as Map<String, dynamic>;
      if ((map['productCode'] ?? '').toString() == code) {
        if (map['_deleted'] == true) {
          alreadyDeleted = true;
        }
        continue;
      }
      next.add(item);
    }
    if (!alreadyDeleted) {
      next.add(jsonEncode({'productCode': code, '_deleted': true}));
    }
    await _box.put(_key, next);
  }

  @override
  Future<void> updateProductCode(String tempCode, String newCode) async {
    if (tempCode.isEmpty || newCode.isEmpty) return;
    final items = _box.get(_key, defaultValue: <String>[]) ?? <String>[];
    var updated = false;
    final next = items.map((item) {
      final map = jsonDecode(item) as Map<String, dynamic>;
      if ((map['productCode'] ?? '').toString() == tempCode) {
        map['productCode'] = newCode;
        map.remove('_offlineTempCode');
        updated = true;
      }
      return jsonEncode(map);
    }).toList();
    if (updated) {
      await _box.put(_key, next);
    }
  }
}
