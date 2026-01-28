import 'dart:async';

import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:store_manage/core/network/connectivity_service.dart';
import 'package:store_manage/core/data/storage/interfaces/offline_queue_storage.dart';
import 'package:store_manage/feature/product/data/repositories/product_repository.dart';

class ProductDeleteSyncService {
  static const String queueKey = 'product_delete_queue';

  final OfflineQueueStorage _queue;
  final ProductRepository _repository;
  final ConnectivityService _connectivity;
  late final StreamSubscription<InternetStatus> _connectivitySub;

  ProductDeleteSyncService(this._queue, this._repository, this._connectivity) {
    _connectivitySub = _connectivity.onChanged.listen((status) {
      if (status == InternetStatus.connected) {
        syncPending();
      }
    });
  }

  Future<void> enqueue(String productCode) {
    return _queue.enqueue(queueKey, {'productCode': productCode});
  }

  Future<void> syncPending() async {
    if (!await _connectivity.isOnline) {
      return;
    }

    final items = await _queue.getAll(queueKey);
    for (var i = 0; i < items.length; i++) {
      final code = (items[i]['productCode'] ?? '').toString();
      if (code.isEmpty) {
        await _queue.removeAt(queueKey, 0);
        continue;
      }
      try {
        await _repository.deleteProduct(code);
        await _queue.removeAt(queueKey, 0);
      } catch (_) {
        break;
      }
    }
  }

  Future<void> dispose() async {
    await _connectivitySub.cancel();
  }
}
