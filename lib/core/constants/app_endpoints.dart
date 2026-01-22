import 'package:flutter_dotenv/flutter_dotenv.dart';

class AppEndpoints {
  static String get BASE_URL => dotenv.isInitialized ? (dotenv.env['API_BASE_URL'] ?? '') : '';
  static String get STOCK_IN => '$BASE_URL/stock-in';
  static String get PRODUCT_SEARCH => '$BASE_URL/products';
  static String productDelete(String code) => '$BASE_URL/products/$code';
  static String get RETAIL_SALE => '$BASE_URL/retail-sale';
}
