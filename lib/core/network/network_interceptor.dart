import 'package:dio/dio.dart';
import 'package:logger/logger.dart';
import 'package:store_manage/core/storage/secure_storage.dart';

class NetworkInterceptor extends Interceptor {
  final SecureStorageImpl secureStorageImpl;
  final Logger _logger = Logger();

  NetworkInterceptor(this.secureStorageImpl);

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    final token = await secureStorageImpl.getAccessToken();
    options.headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      if (token != null) 'Authorization': 'Bearer $token',
    };

    _logger.i('--> ${options.method} ${options.uri}');
    _logger.d('Headers: ${options.headers}');
    _logger.d('Body: ${options.data}');
    return handler.next(options);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    _logger.i('<-- ${response.statusCode} ${response.requestOptions.uri}');
    _logger.d('Response: ${response.data}');
    return handler.next(response);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    _logger.e('*** DioError: ${err.response?.statusCode} ${err.message}');
    return handler.next(err);
  }
}
