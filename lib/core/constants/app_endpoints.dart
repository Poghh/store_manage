import 'package:flutter_dotenv/flutter_dotenv.dart';

class AppEndpoints {
  static String get BASE_URL => dotenv.isInitialized ? (dotenv.env['API_BASE_URL'] ?? '') : '';
  static String get DAILY_SYNC => '$BASE_URL/daily-sync';
  static String get PRODUCT_SEARCH => '$BASE_URL/products';
}
