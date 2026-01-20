import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/services.dart';
import 'package:logger/web.dart';
import 'package:store_manage/config/app_config.dart';
import 'package:store_manage/core/errors/app_exception.dart';
import 'package:store_manage/core/models/common_response_model.dart';
import 'package:store_manage/core/network/network_interceptor.dart';
import 'package:store_manage/core/storage/secure_storage.dart';
import 'package:store_manage/core/utils/common_funtion_utils.dart';

class NetworkClient {
  final Dio _dio;

  NetworkClient(SecureStorageImpl secureStorage)
    : _dio = Dio(
        BaseOptions(
          connectTimeout: Duration(seconds: 15),
          receiveTimeout: Duration(seconds: 15),
          responseType: ResponseType.json,
        ),
      ) {
    _dio.interceptors.add(NetworkInterceptor(secureStorage));
  }

  Future<CommonResponseModel<T>> invoke<T>(
    String url,
    RequestType requestType, {
    Map<String, String>? queryParameters,
    dynamic requestBody,
    required T Function(Object?) fromJsonT,
  }) async {
    try {
      if (AppConfig.isDev) {
        final fileName = CommonFuntionUtils.urlToMockFile(url);
        final jsonString = await rootBundle.loadString('assets/mocks/$fileName.json');
        final jsonMap = jsonDecode(jsonString);

        return CommonResponseModel(status: 200, data: fromJsonT(jsonMap));
      }

      late Response response;

      switch (requestType) {
        case RequestType.get:
          response = await _dio.get(url, queryParameters: queryParameters);
          break;
        case RequestType.post:
          response = await _dio.post(url, data: requestBody, queryParameters: queryParameters);
          break;
        case RequestType.put:
          response = await _dio.put(url, data: requestBody, queryParameters: queryParameters);
          break;
        case RequestType.delete:
          response = await _dio.delete(url, data: requestBody, queryParameters: queryParameters);
          break;
        case RequestType.patch:
          response = await _dio.patch(url, data: requestBody, queryParameters: queryParameters);
          break;
      }

      return CommonResponseModel<T>.fromJson(response.data, fromJsonT);
    } on DioException catch (e) {
      throw ServerException(dioError: e);
    } on SocketException catch (e) {
      Logger().e(e.toString());
      rethrow;
    }
  }
}

enum RequestType { get, post, put, delete, patch }
