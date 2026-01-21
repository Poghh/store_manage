import 'dart:convert';

import 'package:hive/hive.dart';

abstract class RetailTransactionStorage {
  Future<void> addTransaction(Map<String, dynamic> payload);
  List<Map<String, dynamic>> getAll();
}

class HiveRetailTransactionStorage implements RetailTransactionStorage {
  static const String _key = 'retail_transactions';
  final Box<List<String>> _box;

  HiveRetailTransactionStorage(this._box);

  @override
  Future<void> addTransaction(Map<String, dynamic> payload) async {
    final items = _box.get(_key, defaultValue: <String>[]) ?? <String>[];
    items.add(jsonEncode(payload));
    await _box.put(_key, items);
  }

  @override
  List<Map<String, dynamic>> getAll() {
    final items = _box.get(_key, defaultValue: <String>[]) ?? <String>[];
    return items.map((item) => jsonDecode(item) as Map<String, dynamic>).toList();
  }
}
