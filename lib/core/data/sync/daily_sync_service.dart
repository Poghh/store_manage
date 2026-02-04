import 'dart:convert';
import 'dart:io';

import 'package:store_manage/core/data/repositories/daily_sync_repository.dart';
import 'package:store_manage/core/data/repositories/store_repository.dart';
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
  static const String _storeRunSyncKey = 'run_store_sync';
  static const String _storeLastSyncKey = 'last_store_sync';

  final OfflineQueueStorage _queue;
  final DailySyncRepository _repository;
  final StoreRepository _storeRepository;
  final ConnectivityService _connectivity;
  final LocalStorage _localStorage;
  final SecureStorageImpl _secureStorage;
  final LocalProductService _localProductService;
  final InventoryAdjustmentService _inventoryAdjustmentService;

  DailySyncService(
    this._queue,
    this._repository,
    this._storeRepository,
    this._connectivity,
    this._localStorage,
    this._secureStorage,
    this._localProductService,
    this._inventoryAdjustmentService,
  );

  Future<void> enqueueStockIn(Map<String, dynamic> payload) {
    payload.putIfAbsent('syncFlag', () => 'C');
    return _queue.enqueue(stockInQueueKey, payload);
  }

  Future<void> enqueueRetailSale(Map<String, dynamic> payload) {
    payload.putIfAbsent('syncFlag', () => 'C');
    return _queue.enqueue(retailQueueKey, payload);
  }

  Future<void> enqueueProductDelete(String productCode) {
    return _queue.enqueue(productDeleteQueueKey, {'productCode': productCode, 'syncFlag': 'D'});
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

  /// Sync store data to server
  Future<void> syncStore() async {
    if (!await _connectivity.isOnline) return;

    final phone = await _secureStorage.getSavedPhoneNumber();
    if (phone == null || phone.isEmpty) return;

    final syncTime = DateTime.now();

    // Allow store sync only after 20:00 local time
    if (syncTime.hour < 20) {
      return;
    }

    final lastStoreSyncIso = await _localStorage.read(_storeLastSyncKey);
    final lastStoreSync = DateTime.tryParse(lastStoreSyncIso ?? '');
    if (_isSameDay(lastStoreSync, syncTime)) {
      return;
    }

    // Collect only unsynced items (keep unsynced records for future days)
    final stockIns = await _queue.getUnsynced(stockInQueueKey);
    final retailSales = await _queue.getUnsynced(retailQueueKey);
    final productDeletes = await _queue.getUnsynced(productDeleteQueueKey);

    if (stockIns.isEmpty && retailSales.isEmpty && productDeletes.isEmpty) {
      return;
    }

    final syncDataMap = <String, dynamic>{
      'stockIns': _withSyncFlag(stockIns, 'C'),
      'retailSales': _withSyncFlag(retailSales, 'C'),
      'productDeletes': _withSyncFlag(productDeletes, 'D'),
    };

    final syncData = jsonEncode(syncDataMap);

    try {
      final response = await _storeRepository.syncStore(phone: phone, syncTime: syncTime, syncData: syncData);

      // Apply any product code mappings returned by the server
      await _applyProductCodeMappings(response);

      // Mark individual queue rows as synced (use _queueId added by Drift implementation)
      for (final item in stockIns) {
        final id = (item['_queueId'] ?? item['queueId']) as int?;
        if (id != null) await _queue.markSynced(id);
      }
      for (final item in retailSales) {
        final id = (item['_queueId'] ?? item['queueId']) as int?;
        if (id != null) await _queue.markSynced(id);
      }
      for (final item in productDeletes) {
        final id = (item['_queueId'] ?? item['queueId']) as int?;
        if (id != null) await _queue.markSynced(id);
      }

      // Record store sync timestamps
      final syncIso = syncTime.toIso8601String();
      await _localStorage.write(_storeRunSyncKey, syncIso);
      await _localStorage.write(_storeLastSyncKey, syncIso);
    } catch (_) {}
  }

  List<Map<String, dynamic>> _withSyncFlag(List<Map<String, dynamic>> items, String flag) {
    return items.map((item) {
      final copy = Map<String, dynamic>.from(item);
      copy.putIfAbsent('syncFlag', () => flag);
      return copy;
    }).toList();
  }

  bool _isSameDay(DateTime? a, DateTime b) {
    if (a == null) return false;
    return a.year == b.year && a.month == b.month && a.day == b.day;
  }
}
