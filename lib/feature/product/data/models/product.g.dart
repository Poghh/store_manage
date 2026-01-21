// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Product _$ProductFromJson(Map<String, dynamic> json) => _Product(
  productCode: json['productCode'] as String,
  productName: json['productName'] as String,
  unit: json['unit'] as String?,
  image: json['image'] as String?,
  category: json['category'] as String?,
  platform: json['platform'] as String?,
  brand: json['brand'] as String?,
  quantity: (json['quantity'] as num?)?.toInt(),
  purchasePrice: (json['purchasePrice'] as num?)?.toInt(),
  stockInDate: json['stockInDate'] as String?,
);

Map<String, dynamic> _$ProductToJson(_Product instance) => <String, dynamic>{
  'productCode': instance.productCode,
  'productName': instance.productName,
  'unit': instance.unit,
  'image': instance.image,
  'category': instance.category,
  'platform': instance.platform,
  'brand': instance.brand,
  'quantity': instance.quantity,
  'purchasePrice': instance.purchasePrice,
  'stockInDate': instance.stockInDate,
};
