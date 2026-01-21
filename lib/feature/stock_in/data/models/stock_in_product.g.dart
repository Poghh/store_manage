// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'stock_in_product.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_StockInProduct _$StockInProductFromJson(Map<String, dynamic> json) =>
    _StockInProduct(
      productCode: json['productCode'] as String,
      productName: json['productName'] as String,
      unit: json['unit'] as String?,
    );

Map<String, dynamic> _$StockInProductToJson(_StockInProduct instance) =>
    <String, dynamic>{
      'productCode': instance.productCode,
      'productName': instance.productName,
      'unit': instance.unit,
    };
