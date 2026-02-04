import 'dart:convert';

import '../interfaces/offline_queue_storage.dart';
import '../../database/daos/offline_queue_dao.dart';

class DriftOfflineQueueStorage implements OfflineQueueStorage {
  final OfflineQueueDao _dao;

  DriftOfflineQueueStorage(this._dao);

  @override
  Future<List<Map<String, dynamic>>> getAll(String queueKey) async {
    final items = await _dao.getAll(queueKey);
    return items.map((item) {
      try {
        return jsonDecode(item.payload) as Map<String, dynamic>;
      } catch (_) {
        return <String, dynamic>{};
      }
    }).toList();
  }

  @override
  Future<List<Map<String, dynamic>>> getByDateRange(
    String queueKey, {
    required DateTime start,
    required DateTime end,
  }) async {
    final items = await _dao.getByDateRange(queueKey, start: start, end: end);
    return items.map((item) {
      try {
        final payload = jsonDecode(item.payload) as Map<String, dynamic>;
        payload['_createdAt'] = item.createdAt.toIso8601String();
        payload['_queueId'] = item.id;
        return payload;
      } catch (_) {
        return <String, dynamic>{};
      }
    }).toList();
  }

  @override
  Future<void> enqueue(String queueKey, Map<String, dynamic> payload) async {
    await _dao.enqueue(queueKey, jsonEncode(payload));
  }

  @override
  Future<void> removeAt(String queueKey, int index) async {
    if (index != 0) {
      throw UnsupportedError('Drift implementation only supports removing first item');
    }
    await _dao.removeFirst(queueKey);
  }

  @override
  Future<void> clear(String queueKey) async {
    await _dao.clearQueue(queueKey);
  }

  @override
  Future<List<Map<String, dynamic>>> getUnsynced(String queueKey) async {
    final items = await _dao.getUnsynced(queueKey);
    return items.map((item) {
      try {
        final payload = jsonDecode(item.payload) as Map<String, dynamic>;
        payload['_createdAt'] = item.createdAt.toIso8601String();
        payload['_queueId'] = item.id;
        return payload;
      } catch (_) {
        return <String, dynamic>{};
      }
    }).toList();
  }

  @override
  Future<void> markSynced(int id) async {
    await _dao.markSynced(id);
  }
}
