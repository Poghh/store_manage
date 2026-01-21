import 'package:freezed_annotation/freezed_annotation.dart';

part 'stock_in_product.freezed.dart';
part 'stock_in_product.g.dart';

@freezed
abstract class StockInProduct with _$StockInProduct {
  const factory StockInProduct({required String productCode, required String productName, String? unit}) =
      _StockInProduct;

  factory StockInProduct.fromJson(Map<String, dynamic> json) => _$StockInProductFromJson(json);
}
