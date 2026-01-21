import 'package:freezed_annotation/freezed_annotation.dart';

part 'product.freezed.dart';
part 'product.g.dart';

@freezed
abstract class Product with _$Product {
  const factory Product({
    required String productCode,
    required String productName,
    String? unit,
    String? image,
    String? category,
    String? platform,
    String? brand,
    int? quantity,
    int? purchasePrice,
    String? stockInDate,
  }) = _Product;

  factory Product.fromJson(Map<String, dynamic> json) => _$ProductFromJson(json);
}
