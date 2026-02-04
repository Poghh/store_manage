import 'package:flutter_dotenv/flutter_dotenv.dart';

class AppEndpoints {
  static String get BASE_URL => dotenv.isInitialized ? (dotenv.env['API_BASE_URL'] ?? '') : '';
  static String get STORE_NAME => dotenv.isInitialized ? (dotenv.env['APP_NAME'] ?? '') : '';
  static String APP_CREDENTIALS_EXISTS(String phone) =>
      '$BASE_URL/app-credentials/exists?phone=$phone&appName=$STORE_NAME';
  static String APP_CREDENTIALS_SECRET(String phone) =>
      '$BASE_URL/app-credentials/secret?phone=$phone';
  static String get AUTH_TOKEN => '$BASE_URL/auth/token';
  static String get DAILY_SYNC => '$BASE_URL/daily-sync';
  static String get PRODUCT_SEARCH => '$BASE_URL/products';

  // Store endpoints
  static String get STORE_CREATE_INFORMATION => '$BASE_URL/store/create-information';
  static String get STORE_SYNC => '$BASE_URL/store/sync';
}
