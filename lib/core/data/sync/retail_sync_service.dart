import 'package:store_manage/core/data/sync/daily_sync_service.dart';

class RetailSyncService {
  final DailySyncService _dailySyncService;

  RetailSyncService(this._dailySyncService);

  Future<void> enqueue(Map<String, dynamic> payload) => _dailySyncService.enqueueRetailSale(payload);

  Future<void> syncPending() => _dailySyncService.syncPending();
}
