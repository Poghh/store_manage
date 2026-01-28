import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';

import 'package:store_manage/core/constants/app_endpoints.dart';
import 'package:store_manage/core/constants/app_strings.dart';
import 'package:store_manage/core/network/connectivity_service.dart';
import 'package:store_manage/core/data/sync/retail_sync_service.dart';
import 'package:store_manage/core/data/services/inventory_adjustment_service.dart';
import 'package:store_manage/core/data/storage/interfaces/retail_transaction_storage.dart';
import 'package:store_manage/feature/retail/data/repositories/retail_repository.dart';
import 'retail_state.dart';

class RetailCubit extends Cubit<RetailState> {
  final RetailRepository _repository;
  final RetailSyncService _syncService;
  final ConnectivityService _connectivity;
  final RetailTransactionStorage _transactionStorage;
  final InventoryAdjustmentService _inventoryService;
  late final StreamSubscription<InternetStatus> _connectivitySub;

  RetailCubit(this._repository, this._syncService, this._connectivity, this._transactionStorage, this._inventoryService)
    : super(const RetailInitial()) {
    _connectivitySub = _connectivity.onChanged.listen((status) {
      if (status == InternetStatus.connected) {
        _syncService.syncPending();
      }
    });
  }

  Future<void> submitRetailSale(Map<String, dynamic> payload) async {
    emit(const RetailLoading());

    if (AppEndpoints.BASE_URL.isEmpty) {
      emit(const RetailError(AppStrings.stockInApiNotConfigured));
      return;
    }

    if (!await _connectivity.isOnline) {
      await _transactionStorage.addTransaction(payload);
      await _syncService.enqueue(payload);
      await _applyInventoryDeduction(payload);
      emit(const RetailQueued(AppStrings.retailQueued));
      return;
    }

    try {
      await _repository.submitRetailSale(payload);
      await _applyInventoryDeduction(payload);
      emit(const RetailLoaded());
      await _syncService.syncPending();
    } catch (_) {
      await _transactionStorage.addTransaction(payload);
      await _syncService.enqueue(payload);
      await _applyInventoryDeduction(payload);
      emit(const RetailQueued(AppStrings.retailQueued));
    }
  }

  Future<void> _applyInventoryDeduction(Map<String, dynamic> payload) async {
    final code = (payload['productCode'] ?? '').toString();
    final quantity = (payload['quantity'] is int)
        ? payload['quantity'] as int
        : int.tryParse('${payload['quantity']}') ?? 0;
    await _inventoryService.applySale(code, quantity);
  }

  @override
  Future<void> close() {
    _connectivitySub.cancel();
    return super.close();
  }
}
