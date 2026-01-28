import 'package:store_manage/core/network/connectivity_service.dart';
import 'package:store_manage/core/data/services/inventory_adjustment_service.dart';
import 'package:store_manage/core/data/storage/interfaces/offline_queue_storage.dart';
import 'package:store_manage/core/data/services/local_product_service.dart';
import 'package:store_manage/feature/stock_in/data/repositories/stock_in_repository.dart';

class StockInSyncService {
  static const String queueKey = 'stock_in_queue';

  final OfflineQueueStorage _queue;
  final StockInRepository _repository;
  final ConnectivityService _connectivity;
  final LocalProductService _localProductService;
  final InventoryAdjustmentService _inventoryAdjustmentService;

  StockInSyncService(
    this._queue,
    this._repository,
    this._connectivity,
    this._localProductService,
    this._inventoryAdjustmentService,
  );

  Future<void> enqueue(Map<String, dynamic> payload) => _queue.enqueue(queueKey, payload);

  Future<void> syncPending() async {
    if (!await _connectivity.isOnline) {
      return;
    }

    final items = await _queue.getAll(queueKey);
    for (var i = 0; i < items.length; i++) {
      try {
        final response = await _repository.submitStockIn(items[i]);
        final tempCode = (items[i]['_offlineTempCode'] ?? '').toString();
        final newCode = _extractProductCode(response);
        if (tempCode.isNotEmpty && newCode.isNotEmpty) {
          await _localProductService.updateProductCode(tempCode, newCode);

          await _inventoryAdjustmentService.migrateProductCode(from: tempCode, to: newCode);
        }
        await _queue.removeAt(queueKey, 0);
      } catch (_) {
        break;
      }
    }
  }

  String _extractProductCode(Map<String, dynamic> response) {
    if (response['productCode'] != null) {
      return response['productCode'].toString();
    }
    final data = response['data'];
    if (data is Map<String, dynamic> && data['productCode'] != null) {
      return data['productCode'].toString();
    }
    return '';
  }
}
