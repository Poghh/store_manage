import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:store_manage/core/constants/app_endpoints.dart';
import 'package:store_manage/core/constants/app_strings.dart';
import 'package:store_manage/core/data/sync/daily_sync_service.dart';
import 'package:store_manage/core/data/services/inventory_adjustment_service.dart';
import 'package:store_manage/core/data/services/local_product_service.dart';

import 'stock_in_state.dart';

class StockInCubit extends Cubit<StockInState> {
  final DailySyncService _syncService;
  final InventoryAdjustmentService _inventoryService;
  final LocalProductService _localProductService;

  StockInCubit(this._syncService, this._inventoryService, this._localProductService)
    : super(const StockInInitial());

  Future<void> submitStockIn(Map<String, dynamic> payload) async {
    emit(const StockInLoading());

    if (AppEndpoints.BASE_URL.isEmpty) {
      emit(const StockInError(AppStrings.stockInApiNotConfigured));
      return;
    }

    await _prepareOfflinePayload(payload);
    await _syncService.enqueueStockIn(payload);

    payload['_skipInventoryIncrease'] = false;
    await _applyInventoryIncrease(payload);

    emit(const StockInQueued(AppStrings.stockInQueued));
  }

  Future<void> _applyInventoryIncrease(Map<String, dynamic> payload) async {
    final skip = payload['_skipInventoryIncrease'] == true;
    if (skip) return;
    final code = (payload['productCode'] ?? '').toString();
    final quantity = (payload['quantity'] is int)
        ? payload['quantity'] as int
        : int.tryParse('${payload['quantity']}') ?? 0;
    await _inventoryService.applyStockIn(code, quantity);
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

}
