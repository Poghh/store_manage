import 'dart:io';

import 'package:dio/dio.dart';
import 'package:store_manage/core/constants/app_endpoints.dart';
import 'package:store_manage/core/network/network_client.dart';
import 'package:store_manage/feature/stock_in/data/models/stock_in_product.dart';

abstract class StockInRepository {
  Future<Map<String, dynamic>> submitStockIn(Map<String, dynamic> payload);
  Future<List<StockInProduct>> searchProducts(String query);
}

class StockInRepositoryImpl implements StockInRepository {
  final NetworkClient _client;

  StockInRepositoryImpl(this._client);

  @override
  Future<Map<String, dynamic>> submitStockIn(Map<String, dynamic> payload) async {
    final imagePath = _resolveLocalImagePath(payload['image']);
    final requestBody = imagePath != null
        ? FormData.fromMap(_buildMultipartPayload(payload, imagePath))
        : _stripNullValues(payload);
    final response = await _client.invoke<Map<String, dynamic>>(
      AppEndpoints.STOCK_IN,
      RequestType.post,
      requestBody: requestBody,
      fromJsonT: (json) => (json as Map<String, dynamic>?) ?? <String, dynamic>{},
    );
    return response.data;
  }

  @override
  Future<List<StockInProduct>> searchProducts(String query) async {
    final response = await _client.invoke<List<StockInProduct>>(
      AppEndpoints.PRODUCT_SEARCH,
      RequestType.get,
      queryParameters: {'q': query},
      fromJsonT: (json) {
        final list = json is List ? json : const <dynamic>[];
        return list.whereType<Map<String, dynamic>>().map(StockInProduct.fromJson).toList();
      },
    );

    return response.data;
  }

  String? _resolveLocalImagePath(Object? value) {
    if (value == null) return null;
    final raw = value.toString().trim();
    if (raw.isEmpty) return null;
    if (raw.startsWith('http://') || raw.startsWith('https://')) return null;
    final normalized = _normalizeLocalPath(raw);
    final file = File(normalized);
    if (!file.existsSync()) return null;
    return normalized;
  }

  String _normalizeLocalPath(String value) {
    final uri = Uri.tryParse(value);
    if (uri != null && uri.scheme == 'file') {
      return uri.toFilePath();
    }
    return value;
  }

  Map<String, dynamic> _buildMultipartPayload(Map<String, dynamic> payload, String imagePath) {
    final filename = imagePath.split(Platform.pathSeparator).last;
    final next = Map<String, dynamic>.from(payload);
    next['image'] = MultipartFile.fromFileSync(imagePath, filename: filename);
    return _stripNullValues(next);
  }

  Map<String, dynamic> _stripNullValues(Map<String, dynamic> payload) {
    final next = <String, dynamic>{};
    for (final entry in payload.entries) {
      if (entry.value == null) continue;
      next[entry.key] = entry.value;
    }
    return next;
  }
}
