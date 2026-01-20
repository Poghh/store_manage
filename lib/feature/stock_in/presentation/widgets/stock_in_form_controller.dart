import 'package:flutter/material.dart';

import 'package:store_manage/core/constants/app_numbers.dart';
import 'package:store_manage/core/constants/app_strings.dart';

class StockInFormController {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController productNameController = TextEditingController();
  final TextEditingController quantityController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final TextEditingController dateController = TextEditingController();

  String productCode = AppStrings.stockInAutoCodeValue;
  String? category;
  String? platform;
  String? brand;
  String? unit;
  DateTime selectedDate = DateTime.now();

  StockInFormController() {
    dateController.text = _formatDate(selectedDate);
  }

  void dispose() {
    productNameController.dispose();
    quantityController.dispose();
    priceController.dispose();
    dateController.dispose();
  }

  bool validate() => formKey.currentState?.validate() ?? false;

  Map<String, dynamic> buildPayload() {
    return {
      'productCode': productCode,
      'productName': productNameController.text.trim(),
      'category': category,
      'platform': platform,
      'brand': brand,
      'unit': unit,
      'quantity': int.tryParse(quantityController.text.trim()) ?? 0,
      'purchasePrice': _parseCurrencyToInt(priceController.text) ?? 0,
      'stockInDate': _formatDate(selectedDate),
    };
  }

  void updateDate(DateTime value) {
    selectedDate = value;
    dateController.text = _formatDate(value);
  }

  String _formatDate(DateTime value) {
    final day = value.day.toString().padLeft(AppNumbers.INT_2, '0');
    final month = value.month.toString().padLeft(AppNumbers.INT_2, '0');
    final year = value.year.toString();
    return '$day/$month/$year';
  }

  int? _parseCurrencyToInt(String? value) {
    if (value == null || value.trim().isEmpty) {
      return null;
    }
    final digits = value.replaceAll(RegExp(r'[^0-9]'), '');
    if (digits.isEmpty) {
      return null;
    }
    return int.tryParse(digits);
  }
}
