import 'package:store_manage/core/network/connectivity_service.dart';
import 'package:store_manage/core/data/storage/interfaces/offline_queue_storage.dart';
import 'package:store_manage/feature/retail/data/repositories/retail_repository.dart';

class RetailSyncService {
  static const String queueKey = 'retail_sale_queue';

  final OfflineQueueStorage _queue;
  final RetailRepository _repository;
  final ConnectivityService _connectivity;

  RetailSyncService(this._queue, this._repository, this._connectivity);

  Future<void> enqueue(Map<String, dynamic> payload) => _queue.enqueue(queueKey, payload);

  Future<void> syncPending() async {
    if (!await _connectivity.isOnline) {
      return;
    }

    final items = await _queue.getAll(queueKey);
    for (var i = 0; i < items.length; i++) {
      try {
        await _repository.submitRetailSale(items[i]);
        await _queue.removeAt(queueKey, 0);
      } catch (_) {
        break;
      }
    }
  }
}
