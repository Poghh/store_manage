import 'package:store_manage/feature/product/data/models/product.dart';

class ProductSearchState {
  final bool isLoading;
  final List<Product> results;
  final String? error;

  const ProductSearchState({this.isLoading = false, this.results = const [], this.error});

  ProductSearchState copyWith({bool? isLoading, List<Product>? results, String? error}) {
    return ProductSearchState(isLoading: isLoading ?? this.isLoading, results: results ?? this.results, error: error);
  }
}
