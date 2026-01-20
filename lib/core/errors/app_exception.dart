import 'package:dio/dio.dart';
import 'package:store_manage/core/DI/di.dart';
import 'package:store_manage/core/logger/app_logger.dart';

abstract class AppException implements Exception {
  final String message;
  final StackTrace? stackTrace;

  AppException(this.message, [this.stackTrace]) {
    final logger = di<AppLogger>();
    logger.e('$runtimeType: $message');
  }

  @override
  String toString() => '$runtimeType: $message';
}

class UnknownException extends AppException {
  UnknownException([super.message = 'Unknown error occurred']);
}

class ValidationException extends AppException {
  ValidationException(super.message);
}

class ServerException extends AppException {
  final int? statusCode;
  final DioException? dioError;

  ServerException({
    String? message,
    this.dioError,
    this.statusCode,
    StackTrace? stackTrace,
  }) : super(
          message ?? dioError?.message ?? 'Server error occurred',
          stackTrace ?? dioError?.stackTrace,
        ) {
    final logger = di<AppLogger>();
    logger.e(
      'ServerException (StatusCode: $statusCode): $message\n${dioError?.toString()}',
      dioError,
      dioError?.stackTrace,
    );
  }
}
