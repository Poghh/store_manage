import 'package:flutter/foundation.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/intl.dart';

import 'package:store_manage/core/storage/retail_transaction_storage.dart';

class RetailRevenueService {
  final RetailTransactionStorage _storage;

  RetailRevenueService(this._storage);

  ValueListenable<Box<List<String>>> get listenable => Hive.box<List<String>>('retail_transactions').listenable();

  int offlineRevenueForDate(String dateKey) {
    final items = _storage.getAll();
    var total = 0;
    for (final item in items) {
      final createdAt = DateTime.tryParse((item['createdAt'] ?? '').toString());
      if (createdAt == null) continue;
      final itemDateKey = DateFormat('yyyy-MM-dd').format(createdAt);
      if (itemDateKey != dateKey) continue;
      final value = (item['total'] is int) ? item['total'] as int : int.tryParse('${item['total']}') ?? 0;
      total += value;
    }
    return total;
  }
}
