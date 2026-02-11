import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:store_manage/core/data/repositories/media_repository.dart';
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
  static const String _lastSyncKey = 'last_sync';

  final OfflineQueueStorage _queue;
  final StoreRepository _storeRepository;
  final MediaRepository _mediaRepository;
  final ConnectivityService _connectivity;
  final LocalStorage _localStorage;
  final SecureStorageImpl _secureStorage;
  final LocalProductService _localProductService;
  final InventoryAdjustmentService _inventoryAdjustmentService;

  StreamSubscription<InternetStatus>? _connectivitySub;

  DailySyncService(
    this._queue,
    this._storeRepository,
    this._mediaRepository,
    this._connectivity,
    this._localStorage,
    this._secureStorage,
    this._localProductService,
    this._inventoryAdjustmentService,
  );

  /// Bắt đầu lắng nghe kết nối mạng để tự động sync
  /// Chỉ sync sau 20:00 và 1 lần/ngày
  void startListening() {
    if (_connectivitySub != null) return;

    // Thử sync ngay khi khởi động (phòng trường hợp mạng đã ổn định)
    syncAll();

    _connectivitySub = _connectivity.onChanged.listen((status) {
      if (status == InternetStatus.connected) {
        syncAll();
      }
    });
  }

  void dispose() {
    _connectivitySub?.cancel();
    _connectivitySub = null;
  }

  Future<void> enqueueStockIn(Map<String, dynamic> payload) {
    payload.putIfAbsent('syncFlag', () => 'C');
    return _queue.enqueue(stockInQueueKey, payload);
  }

  Future<void> enqueueRetailSale(Map<String, dynamic> payload) {
    payload.putIfAbsent('syncFlag', () => 'C');
    return _queue.enqueue(retailQueueKey, payload);
  }

  Future<void> enqueueProductDelete(String productCode) {
    return _queue.enqueue(stockInQueueKey, {'productCode': productCode, 'syncFlag': 'D'});
  }

  /// Sync tất cả dữ liệu — chỉ chạy sau 20:00, 1 lần/ngày
  Future<void> syncAll() async {
    if (!await _connectivity.isOnline) return;

    final now = DateTime.now();
    if (now.hour < 12) return;

    final lastSyncIso = await _localStorage.read(_lastSyncKey);
    final lastSync = DateTime.tryParse(lastSyncIso ?? '');
    if (_isSameDay(lastSync, now)) return;

    final phone = await _secureStorage.getSavedPhoneNumber();
    if (phone == null || phone.isEmpty) return;

    final stockIns = await _queue.getUnsynced(stockInQueueKey);
    final retailSales = await _queue.getUnsynced(retailQueueKey);

    if (stockIns.isEmpty && retailSales.isEmpty) {
      await _localStorage.write(_lastSyncKey, now.toIso8601String());
      return;
    }

    // Upload ảnh local trước, tách items thành công và thất bại
    final readyStockIns = await _uploadLocalImages(stockIns);

    final syncDataMap = <String, dynamic>{'stockIns': readyStockIns, 'retailSales': _withSyncFlag(retailSales, 'C')};

    try {
      final response = await _storeRepository.syncStore(phone: phone, syncTime: now, syncData: jsonEncode(syncDataMap));

      await _applyProductCodeMappings(response);

      // Đánh dấu đã sync (chỉ items thành công)
      for (final item in [...readyStockIns, ...retailSales]) {
        final id = (item['_queueId'] ?? item['queueId']) as int?;
        if (id != null) await _queue.markSynced(id);
      }

      await _localStorage.write(_lastSyncKey, now.toIso8601String());
    } catch (_) {}
  }

  /// Upload ảnh local lên server, trả về danh sách items sẵn sàng sync
  /// Items có ảnh upload fail sẽ bị loại (giữ unsynced cho lần sau)
  Future<List<Map<String, dynamic>>> _uploadLocalImages(List<Map<String, dynamic>> items) async {
    final ready = <Map<String, dynamic>>[];

    for (final item in items) {
      final image = (item['image'] ?? '').toString();

      if (image.isEmpty || image.startsWith('http')) {
        // Không có ảnh hoặc đã là URL → sẵn sàng
        ready.add(item);
        continue;
      }

      // Local file path → upload
      if (!File(image).existsSync()) {
        // File không tồn tại → sync không có ảnh
        item['image'] = null;
        ready.add(item);
        continue;
      }

      final url = await _mediaRepository.uploadImage(image);
      if (url != null && url.isNotEmpty) {
        item['image'] = url;
        ready.add(item);
      }
      // Upload fail → không thêm vào ready → giữ unsynced cho retry
    }

    return ready;
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
