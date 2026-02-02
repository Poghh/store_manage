import 'dart:async';

import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:store_manage/core/network/connectivity_service.dart';
import 'package:store_manage/core/data/sync/daily_sync_service.dart';

class ProductDeleteSyncService {
  final DailySyncService _dailySyncService;
  final ConnectivityService _connectivity;
  late final StreamSubscription<InternetStatus> _connectivitySub;

  ProductDeleteSyncService(this._dailySyncService, this._connectivity) {
    _connectivitySub = _connectivity.onChanged.listen((status) {
      if (status == InternetStatus.connected) {
        syncPending();
      }
    });
  }

  Future<void> enqueue(String productCode) => _dailySyncService.enqueueProductDelete(productCode);

  Future<void> syncPending() async {
    if (!await _connectivity.isOnline) return;
    await _dailySyncService.syncPending();
  }

  Future<void> dispose() async {
    await _connectivitySub.cancel();
  }
}
