import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:store_manage/core/constants/app_endpoints.dart';
import 'package:store_manage/core/constants/app_strings.dart';
import 'package:store_manage/feature/stock_in/data/repositories/stock_in_repository.dart';

import 'stock_in_state.dart';

class StockInCubit extends Cubit<StockInState> {
  final StockInRepository _repository;

  StockInCubit(this._repository) : super(const StockInInitial());

  Future<void> submitStockIn(Map<String, dynamic> payload) async {
    emit(const StockInLoading());

    if (AppEndpoints.BASE_URL.isEmpty) {
      emit(const StockInError(AppStrings.stockInApiNotConfigured));
      return;
    }

    try {
      await _repository.submitStockIn(payload);

      emit(const StockInLoaded());
    } catch (_) {
      emit(const StockInError(AppStrings.stockInSubmitError));
    }
  }
}
