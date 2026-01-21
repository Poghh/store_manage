import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:store_manage/feature/product/data/models/product.dart';
import 'package:store_manage/feature/product/data/repositories/product_repository.dart';
import 'package:store_manage/feature/product/presentation/cubit/product_search_state.dart';

class ProductSearchCubit extends Cubit<ProductSearchState> {
  final ProductRepository _repository;
  final List<Product> _allProducts = [];
  String _lastQuery = '';
  bool _isPriming = false;

  ProductSearchCubit(this._repository) : super(const ProductSearchState());

  Future<void> prime() async {
    if (_allProducts.isNotEmpty || _isPriming) {
      return;
    }
    _isPriming = true;
    try {
      final items = await _repository.searchProducts('');
      _allProducts
        ..clear()
        ..addAll(items);
    } catch (_) {
      // ignore
    } finally {
      _isPriming = false;
    }
  }

  Future<void> search(String query) async {
    final keyword = query.trim();
    _lastQuery = keyword;
    if (keyword.isEmpty) {
      emit(const ProductSearchState());
      return;
    }

    if (_allProducts.isNotEmpty) {
      _emitFiltered(keyword, _allProducts);
      return;
    }

    emit(state.copyWith(isLoading: true, error: null));

    try {
      final items = await _repository.searchProducts(keyword);
      _allProducts
        ..clear()
        ..addAll(items);
      _emitFiltered(_lastQuery, _allProducts);
    } catch (e) {
      emit(state.copyWith(isLoading: false, error: e.toString(), results: const []));
    }
  }

  void clear() {
    emit(const ProductSearchState());
  }

  void _emitFiltered(String keyword, List<Product> source) {
    final lower = keyword.toLowerCase();
    final filtered = source.where((item) {
      return item.productCode.toLowerCase().contains(lower) || item.productName.toLowerCase().contains(lower);
    }).toList();

    emit(ProductSearchState(isLoading: false, results: filtered));
  }
}
