import 'dart:convert';
import 'dart:io';

import 'package:store_manage/core/data/repositories/daily_sync_repository.dart';
import 'package:store_manage/core/data/services/inventory_adjustment_service.dart';
import 'package:store_manage/core/data/services/local_product_service.dart';
import 'package:store_manage/core/data/storage/interfaces/offline_queue_storage.dart';
import 'package:store_manage/core/data/storage/local_storage.dart';
import 'package:store_manage/core/data/storage/secure_storage.dart';
import 'package:store_manage/core/network/connectivity_service.dart';

class DailySyncService {
  static const String stockInQueueKey = 'stock_in_queue';
  static const String retailQueueKey = 'retail_sale_queue';
  static const String productDeleteQueueKey = 'product_delete_queue';
  static const String _lastSyncKey = 'last_sync';
  static const String _runSyncKey = 'run_sync';

  final OfflineQueueStorage _queue;
  final DailySyncRepository _repository;
  final ConnectivityService _connectivity;
  final LocalStorage _localStorage;
  final SecureStorageImpl _secureStorage;
  final LocalProductService _localProductService;
  final InventoryAdjustmentService _inventoryAdjustmentService;

  DailySyncService(
    this._queue,
    this._repository,
    this._connectivity,
    this._localStorage,
    this._secureStorage,
    this._localProductService,
    this._inventoryAdjustmentService,
  );

  Future<void> enqueueStockIn(Map<String, dynamic> payload) => _queue.enqueue(stockInQueueKey, payload);

  Future<void> enqueueRetailSale(Map<String, dynamic> payload) => _queue.enqueue(retailQueueKey, payload);

  Future<void> enqueueProductDelete(String productCode) {
    return _queue.enqueue(productDeleteQueueKey, {'productCode': productCode});
  }

  Future<void> syncPending({DateTime? now}) async {
    if (!await _connectivity.isOnline) return;

    final runSync = now ?? DateTime.now();
    final runSyncIso = runSync.toIso8601String();

    final lastSyncIso = await _localStorage.read(_lastSyncKey);
    final lastSync = DateTime.tryParse(lastSyncIso ?? '');
    final start = lastSync ?? DateTime(runSync.year, runSync.month, runSync.day);

    if (!runSync.isAfter(start)) return;

    final stockIns = await _queue.getByDateRange(stockInQueueKey, start: start, end: runSync);
    final retailSales = await _queue.getByDateRange(retailQueueKey, start: start, end: runSync);
    final productDeletes = await _queue.getByDateRange(productDeleteQueueKey, start: start, end: runSync);

    if (stockIns.isEmpty && retailSales.isEmpty && productDeletes.isEmpty) {
      await _localStorage.write(_runSyncKey, runSyncIso);
      await _localStorage.write(_lastSyncKey, runSyncIso);
      return;
    }

    final dataBody = <String, dynamic>{
      'stockIns': stockIns,
      'retailSales': retailSales,
      'productDeletes': productDeletes,
    };

    final gzipData = _gzipBase64(jsonEncode(dataBody));
    final userId = await _secureStorage.getUserId();
    final payload = <String, dynamic>{
      'userId': userId,
      'runSync': runSyncIso,
      'lastSync': lastSyncIso,
      'gzipData': gzipData,
      'gzipType': 'base64',
      'contentEncoding': 'gzip',
    };

    final response = await _repository.submitDailySync(payload);
    await _applyProductCodeMappings(response);

    await _queue.clear(stockInQueueKey);
    await _queue.clear(retailQueueKey);
    await _queue.clear(productDeleteQueueKey);
    await _localStorage.write(_runSyncKey, runSyncIso);
    await _localStorage.write(_lastSyncKey, runSyncIso);
  }

  String _gzipBase64(String value) {
    final bytes = utf8.encode(value);
    final gzipped = GZipCodec().encode(bytes);
    return base64Encode(gzipped);
  }

  Future<void> _applyProductCodeMappings(Map<String, dynamic> response) async {
    final mappings = response['productCodeMappings'] ?? response['codeMappings'] ?? response['mappings'];
    if (mappings is! List) return;

    for (final item in mappings) {
      if (item is! Map<String, dynamic>) continue;
      final tempCode = (item['tempCode'] ?? item['offlineTempCode'] ?? item['oldCode'] ?? '').toString();
      final newCode = (item['productCode'] ?? item['newCode'] ?? item['code'] ?? '').toString();
      if (tempCode.isEmpty || newCode.isEmpty) continue;

      await _localProductService.updateProductCode(tempCode, newCode);
      await _inventoryAdjustmentService.migrateProductCode(from: tempCode, to: newCode);
    }
  }
}
