abstract class OfflineQueueStorage {
  Future<List<Map<String, dynamic>>> getAll(String queueKey);
  Future<List<Map<String, dynamic>>> getByDateRange(String queueKey, {required DateTime start, required DateTime end});
  Future<void> enqueue(String queueKey, Map<String, dynamic> payload);
  Future<void> removeAt(String queueKey, int index);
  Future<void> clear(String queueKey);

  /// Get unsynced items (those without a sync timestamp) for the queue.
  /// Returned maps should include an `_queueId` key with the internal row id
  /// and `_createdAt` with the creation ISO timestamp.
  Future<List<Map<String, dynamic>>> getUnsynced(String queueKey);

  /// Mark a queue row as synced by its internal id.
  Future<void> markSynced(int id);
}
