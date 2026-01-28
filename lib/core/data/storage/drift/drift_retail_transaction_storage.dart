import 'dart:convert';

import 'package:drift/drift.dart';

import '../interfaces/retail_transaction_storage.dart';
import '../../database/app_database.dart';
import '../../database/daos/retail_transaction_dao.dart';

class DriftRetailTransactionStorage implements RetailTransactionStorage {
  final RetailTransactionDao _dao;

  DriftRetailTransactionStorage(this._dao);

  @override
  Future<void> addTransaction(Map<String, dynamic> payload) async {
    final extraFields = Map<String, dynamic>.from(payload);
    extraFields.remove('productCode');
    extraFields.remove('productName');
    extraFields.remove('quantity');
    extraFields.remove('total');
    extraFields.remove('createdAt');

    final companion = RetailTransactionsTableCompanion(
      productCode: Value(payload['productCode']?.toString() ?? ''),
      productName: Value(payload['productName']?.toString()),
      quantity: Value(payload['quantity'] as int? ?? 0),
      total: Value(payload['total'] as int? ?? 0),
      createdAt: Value(
        DateTime.tryParse(payload['createdAt']?.toString() ?? '') ??
            DateTime.now(),
      ),
      extraData:
          Value(extraFields.isNotEmpty ? jsonEncode(extraFields) : null),
    );
    await _dao.insertTransaction(companion);
  }

  @override
  Future<List<Map<String, dynamic>>> getAll() async {
    final transactions = await _dao.getAllTransactions();
    return transactions.map(_dataToMap).toList();
  }

  Map<String, dynamic> _dataToMap(RetailTransactionsTableData data) {
    final map = <String, dynamic>{
      'productCode': data.productCode,
      'productName': data.productName,
      'quantity': data.quantity,
      'total': data.total,
      'createdAt': data.createdAt.toIso8601String(),
    };

    if (data.extraData != null) {
      try {
        final extra = jsonDecode(data.extraData!) as Map<String, dynamic>;
        map.addAll(extra);
      } catch (_) {}
    }

    return map;
  }
}
