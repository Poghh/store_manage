abstract class OfflineQueueStorage {
  Future<List<Map<String, dynamic>>> getAll(String queueKey);
  Future<void> enqueue(String queueKey, Map<String, dynamic> payload);
  Future<void> removeAt(String queueKey, int index);
  Future<void> clear(String queueKey);
}
