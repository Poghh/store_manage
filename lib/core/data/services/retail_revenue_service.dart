import 'package:intl/intl.dart';

import 'package:store_manage/core/network/network_client.dart';
import 'package:store_manage/core/data/storage/interfaces/retail_transaction_storage.dart';

class RetailRevenueService {
  final RetailTransactionStorage _storage;
  final NetworkClient _networkClient;
  final Map<String, int> _apiRevenueCache = {};
  bool _isApiDataLoaded = false;

  RetailRevenueService(this._storage, this._networkClient);

  /// Load revenue data - NetworkClient auto handles mock (dev) / real API (stg/prod)
  Future<void> loadApiData() async {
    if (_isApiDataLoaded) return;
    try {
      final response = await _networkClient.invoke<Map<String, dynamic>>(
        '/revenue',
        RequestType.get,
        fromJsonT: (json) => json as Map<String, dynamic>,
      );
      _parseRevenueData(response.data);
      _isApiDataLoaded = true;
    } catch (_) {}
  }

  void _parseRevenueData(Map<String, dynamic> json) {
    final records = (json['records'] as List<dynamic>? ?? []);
    for (final record in records) {
      if (record is Map<String, dynamic>) {
        final date = (record['date'] ?? '').toString();
        final revenue = (record['revenue'] is int)
            ? record['revenue'] as int
            : int.tryParse('${record['revenue']}') ?? 0;
        _apiRevenueCache[date] = revenue;
      }
    }
  }

  /// Get revenue from API/server for a specific date
  int getApiRevenueForDate(String dateKey) {
    return _apiRevenueCache[dateKey] ?? 0;
  }

  /// Get revenue from offline/local transactions for a specific date
  Future<int> getOfflineRevenueForDate(String dateKey) async {
    final items = await _storage.getAll();
    var total = 0;
    for (final item in items) {
      final createdAt = DateTime.tryParse((item['createdAt'] ?? '').toString());
      if (createdAt == null) continue;
      final itemDateKey = DateFormat('yyyy-MM-dd').format(createdAt);
      if (itemDateKey != dateKey) continue;
      final value = (item['total'] is int)
          ? item['total'] as int
          : int.tryParse('${item['total']}') ?? 0;
      total += value;
    }
    return total;
  }

  /// Get total revenue (API + offline) for a specific date
  Future<int> getTotalRevenueForDate(String dateKey) async {
    return getApiRevenueForDate(dateKey) + await getOfflineRevenueForDate(dateKey);
  }

  /// Get total revenue for today
  Future<int> getTodayRevenue() async {
    final today = DateFormat('yyyy-MM-dd').format(DateTime.now());
    return getTotalRevenueForDate(today);
  }

  /// Get total revenue for yesterday
  Future<int> getYesterdayRevenue() async {
    final yesterday = DateTime.now().subtract(const Duration(days: 1));
    final yesterdayKey = DateFormat('yyyy-MM-dd').format(yesterday);
    return getTotalRevenueForDate(yesterdayKey);
  }

  double calculateGrowthPercentage(int todayRevenue, int yesterdayRevenue) {
    if (yesterdayRevenue == 0) {
      return todayRevenue > 0 ? 100.0 : 0.0;
    }
    return ((todayRevenue - yesterdayRevenue) / yesterdayRevenue) * 100;
  }
}
