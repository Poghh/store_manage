class StockInProduct {
  final String code;
  final String name;
  final String? unit;

  const StockInProduct({required this.code, required this.name, this.unit});

  factory StockInProduct.fromJson(Map<String, dynamic> json) {
    return StockInProduct(
      code: (json['code'] ?? json['productCode'] ?? '').toString(),
      name: (json['name'] ?? json['productName'] ?? '').toString(),
      unit: json['unit']?.toString(),
    );
  }
}
