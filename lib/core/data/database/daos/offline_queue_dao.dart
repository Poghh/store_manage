import 'package:drift/drift.dart';

import '../app_database.dart';
import '../tables/offline_queue_table.dart';

part 'offline_queue_dao.g.dart';

@DriftAccessor(tables: [OfflineQueueTable])
class OfflineQueueDao extends DatabaseAccessor<AppDatabase> with _$OfflineQueueDaoMixin {
  OfflineQueueDao(super.db);

  Future<List<OfflineQueueTableData>> getAll(String queueKey) {
    return (select(offlineQueueTable)
          ..where((t) => t.queueKey.equals(queueKey))
          ..orderBy([(t) => OrderingTerm.asc(t.id)]))
        .get();
  }

  Future<List<OfflineQueueTableData>> getByDateRange(
    String queueKey, {
    required DateTime start,
    required DateTime end,
  }) {
    return (select(offlineQueueTable)
          ..where(
            (t) =>
                t.queueKey.equals(queueKey) &
                t.createdAt.isBiggerOrEqualValue(start) &
                t.createdAt.isSmallerOrEqualValue(end),
          )
          ..orderBy([(t) => OrderingTerm.asc(t.id)]))
        .get();
  }

  Future<int> enqueue(String queueKey, String payload) {
    return into(
      offlineQueueTable,
    ).insert(OfflineQueueTableCompanion(queueKey: Value(queueKey), payload: Value(payload)));
  }

  Future<void> removeFirst(String queueKey) async {
    final first =
        await (select(offlineQueueTable)
              ..where((t) => t.queueKey.equals(queueKey))
              ..orderBy([(t) => OrderingTerm.asc(t.id)])
              ..limit(1))
            .getSingleOrNull();
    if (first != null) {
      await (delete(offlineQueueTable)..where((t) => t.id.equals(first.id))).go();
    }
  }

  Future<void> clearQueue(String queueKey) async {
    await (delete(offlineQueueTable)..where((t) => t.queueKey.equals(queueKey))).go();
  }

  Future<List<OfflineQueueTableData>> getUnsynced(String queueKey) {
    return (select(offlineQueueTable)
          ..where((t) => t.queueKey.equals(queueKey) & t.syncedAt.isNull())
          ..orderBy([(t) => OrderingTerm.asc(t.id)]))
        .get();
  }

  Future<void> markSynced(int id) async {
    await (update(
      offlineQueueTable,
    )..where((t) => t.id.equals(id))).write(OfflineQueueTableCompanion(syncedAt: Value(DateTime.now())));
  }
}
