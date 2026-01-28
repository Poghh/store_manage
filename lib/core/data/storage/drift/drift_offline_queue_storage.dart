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
}
