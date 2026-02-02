abstract class OfflineQueueStorage {
  Future<List<Map<String, dynamic>>> getAll(String queueKey);
  Future<List<Map<String, dynamic>>> getByDateRange(String queueKey, {required DateTime start, required DateTime end});
  Future<void> enqueue(String queueKey, Map<String, dynamic> payload);
  Future<void> removeAt(String queueKey, int index);
  Future<void> clear(String queueKey);
}
