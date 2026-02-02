import 'package:store_manage/core/data/sync/daily_sync_service.dart';

class StockInSyncService {
  final DailySyncService _dailySyncService;

  StockInSyncService(this._dailySyncService);

  Future<void> enqueue(Map<String, dynamic> payload) => _dailySyncService.enqueueStockIn(payload);

  Future<void> syncPending() => _dailySyncService.syncPending();
}
