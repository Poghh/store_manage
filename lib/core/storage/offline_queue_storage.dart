import 'dart:convert';

import 'package:hive/hive.dart';

abstract class OfflineQueueStorage {
  List<Map<String, dynamic>> getAll(String queueKey);
  Future<void> enqueue(String queueKey, Map<String, dynamic> payload);
  Future<void> removeAt(String queueKey, int index);
  Future<void> clear(String queueKey);
}

class HiveOfflineQueueStorage implements OfflineQueueStorage {
  final Box<List<String>> _box;

  HiveOfflineQueueStorage(this._box);

  @override
  List<Map<String, dynamic>> getAll(String queueKey) {
    final raw = _box.get(queueKey, defaultValue: <String>[]);
    if (raw == null) return <Map<String, dynamic>>[];
    return raw.map((item) => jsonDecode(item)).whereType<Map<String, dynamic>>().toList();
  }

  @override
  Future<void> enqueue(String queueKey, Map<String, dynamic> payload) async {
    final items = _box.get(queueKey, defaultValue: <String>[]) ?? <String>[];
    items.add(jsonEncode(payload));
    await _box.put(queueKey, items);
  }

  @override
  Future<void> removeAt(String queueKey, int index) async {
    final items = _box.get(queueKey, defaultValue: <String>[]) ?? <String>[];
    if (index < 0 || index >= items.length) return;
    items.removeAt(index);
    await _box.put(queueKey, items);
  }

  @override
  Future<void> clear(String queueKey) async {
    await _box.put(queueKey, <String>[]);
  }
}
