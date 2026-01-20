class Product {
  final String code;
  final String name;
  final String? unit;
  final String? image;
  final String? category;
  final String? platform;
  final String? brand;
  final int? quantity;
  final int? purchasePrice;
  final String? stockInDate;

  const Product({
    required this.code,
    required this.name,
    this.unit,
    this.image,
    this.category,
    this.platform,
    this.brand,
    this.quantity,
    this.purchasePrice,
    this.stockInDate,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      code: (json['code'] ?? json['productCode'] ?? '').toString(),
      name: (json['name'] ?? json['productName'] ?? '').toString(),
      unit: json['unit']?.toString(),
      image: json['image']?.toString(),
      category: json['category']?.toString(),
      platform: json['platform']?.toString(),
      brand: json['brand']?.toString(),
      quantity: _parseInt(json['quantity']),
      purchasePrice: _parseInt(json['purchasePrice']),
      stockInDate: json['stockInDate']?.toString(),
    );
  }

  static int? _parseInt(dynamic value) {
    if (value == null) {
      return null;
    }
    if (value is int) {
      return value;
    }
    return int.tryParse(value.toString());
  }
}
