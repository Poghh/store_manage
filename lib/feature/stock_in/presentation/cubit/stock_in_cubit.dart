import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:store_manage/core/constants/app_endpoints.dart';
import 'package:store_manage/core/constants/app_strings.dart';
import 'package:store_manage/core/network/connectivity_service.dart';
import 'package:store_manage/core/offline/stock_in/stock_in_sync_service.dart';
import 'package:store_manage/core/services/inventory_adjustment_service.dart';
import 'package:store_manage/core/services/local_product_service.dart';
import 'package:store_manage/feature/stock_in/data/repositories/stock_in_repository.dart';

import 'stock_in_state.dart';

class StockInCubit extends Cubit<StockInState> {
  final StockInRepository _repository;
  final StockInSyncService _syncService;
  final ConnectivityService _connectivity;
  final InventoryAdjustmentService _inventoryService;
  final LocalProductService _localProductService;
  late final StreamSubscription<ConnectivityResult> _connectivitySub;

  StockInCubit(
    this._repository,
    this._syncService,
    this._connectivity,
    this._inventoryService,
    this._localProductService,
  ) : super(const StockInInitial()) {
    _connectivitySub = _connectivity.onChanged.listen((result) {
      if (result != ConnectivityResult.none) {
        _syncService.syncPending();
      }
    });
  }

  Future<void> submitStockIn(Map<String, dynamic> payload) async {
    emit(const StockInLoading());

    if (AppEndpoints.BASE_URL.isEmpty) {
      emit(const StockInError(AppStrings.stockInApiNotConfigured));
      return;
    }

    final isOnline = await _connectivity.isOnline;

    if (!isOnline) {
      await _prepareOfflinePayload(payload);
      await _syncService.enqueue(payload);

      payload['_skipInventoryIncrease'] = false;
      _applyInventoryIncrease(payload);

      emit(const StockInQueued(AppStrings.stockInQueued));
      return;
    }

    try {
      await _repository.submitStockIn(payload);
      _applyInventoryIncrease(payload);

      emit(const StockInLoaded());
      await _syncService.syncPending();
    } catch (_) {
      await _prepareOfflinePayload(payload);
      await _syncService.enqueue(payload);

      payload['_skipInventoryIncrease'] = false;
      _applyInventoryIncrease(payload);

      emit(const StockInQueued(AppStrings.stockInQueued));
    }
  }

  void _applyInventoryIncrease(Map<String, dynamic> payload) {
    final skip = payload['_skipInventoryIncrease'] == true;
    if (skip) return;
    final code = (payload['productCode'] ?? '').toString();
    final quantity = (payload['quantity'] is int)
        ? payload['quantity'] as int
        : int.tryParse('${payload['quantity']}') ?? 0;
    _inventoryService.applyStockIn(code, quantity);
  }

  Future<void> _prepareOfflinePayload(Map<String, dynamic> payload) async {
    final code = (payload['productCode'] ?? '').toString().trim();
    final needsTemp =
        payload['_skipInventoryIncrease'] == true || code.isEmpty || code == AppStrings.stockInAutoCodeValue;
    if (!needsTemp) return;
    if (payload['_offlineTempCode'] != null) return;

    final tempCode = 'OFFLINE-${DateTime.now().millisecondsSinceEpoch}';
    payload['_offlineTempCode'] = tempCode;
    payload['productCode'] = tempCode;
    payload['_skipInventoryIncrease'] = true;

    // Save local product with quantity = 0, adjustment will track actual quantity
    final localPayload = Map<String, dynamic>.from(payload);
    localPayload['quantity'] = 0;
    await _localProductService.addFromStockInPayload(localPayload);
  }

  @override
  Future<void> close() {
    _connectivitySub.cancel();
    return super.close();
  }
}
