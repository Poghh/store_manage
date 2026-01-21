import 'package:store_manage/core/network/connectivity_service.dart';
import 'package:store_manage/core/storage/offline_queue_storage.dart';
import 'package:store_manage/feature/stock_in/data/repositories/stock_in_repository.dart';

class StockInSyncService {
  static const String queueKey = 'stock_in_queue';

  final OfflineQueueStorage _queue;
  final StockInRepository _repository;
  final ConnectivityService _connectivity;

  StockInSyncService(this._queue, this._repository, this._connectivity);

  Future<void> enqueue(Map<String, dynamic> payload) => _queue.enqueue(queueKey, payload);

  Future<void> syncPending() async {
    if (!await _connectivity.isOnline) {
      return;
    }

    final items = _queue.getAll(queueKey);
    for (var i = 0; i < items.length; i++) {
      try {
        await _repository.submitStockIn(items[i]);
        await _queue.removeAt(queueKey, 0);
      } catch (_) {
        break;
      }
    }
  }
}
