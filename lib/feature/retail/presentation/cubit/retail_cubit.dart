import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:store_manage/core/constants/app_endpoints.dart';
import 'package:store_manage/core/constants/app_strings.dart';
import 'package:store_manage/core/data/sync/daily_sync_service.dart';
import 'package:store_manage/core/data/services/inventory_adjustment_service.dart';
import 'package:store_manage/core/data/storage/interfaces/retail_transaction_storage.dart';
import 'retail_state.dart';

class RetailCubit extends Cubit<RetailState> {
  final DailySyncService _syncService;
  final RetailTransactionStorage _transactionStorage;
  final InventoryAdjustmentService _inventoryService;

  RetailCubit(this._syncService, this._transactionStorage, this._inventoryService)
    : super(const RetailInitial());

  Future<void> submitRetailSale(Map<String, dynamic> payload) async {
    emit(const RetailLoading());

    if (AppEndpoints.BASE_URL.isEmpty) {
      emit(const RetailError(AppStrings.stockInApiNotConfigured));
      return;
    }

    await _transactionStorage.addTransaction(payload);
    await _syncService.enqueueRetailSale(payload);
    await _applyInventoryDeduction(payload);
    emit(const RetailQueued(AppStrings.retailQueued));
  }

  Future<void> _applyInventoryDeduction(Map<String, dynamic> payload) async {
    final code = (payload['productCode'] ?? '').toString();
    final quantity = (payload['quantity'] is int)
        ? payload['quantity'] as int
        : int.tryParse('${payload['quantity']}') ?? 0;
    await _inventoryService.applySale(code, quantity);
  }
}
