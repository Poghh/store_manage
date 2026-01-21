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

  void applyPrefill({
    String? productCode,
    String? productName,
    String? category,
    String? platform,
    String? brand,
    String? unit,
    int? quantity,
    int? purchasePrice,
    String? stockInDate,
  }) {
    if (productCode != null && productCode.trim().isNotEmpty) {
      this.productCode = productCode.trim();
    }
    if (productName != null && productName.trim().isNotEmpty) {
      productNameController.text = productName.trim();
    }
    if (category != null && category.trim().isNotEmpty) {
      this.category = category;
    }
    if (platform != null && platform.trim().isNotEmpty) {
      this.platform = platform;
    }
    if (brand != null && brand.trim().isNotEmpty) {
      this.brand = brand;
    }
    if (unit != null && unit.trim().isNotEmpty) {
      this.unit = unit;
    }
    if (quantity != null && quantity > 0) {
      quantityController.text = quantity.toString();
    }
    if (purchasePrice != null && purchasePrice > 0) {
      priceController.text = purchasePrice.toString();
    }
    final parsedDate = _tryParseDate(stockInDate);
    if (parsedDate != null) {
      updateDate(parsedDate);
    }
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

  DateTime? _tryParseDate(String? value) {
    if (value == null || value.trim().isEmpty) {
      return null;
    }
    final parts = value.split('/');
    if (parts.length != AppNumbers.INT_3) {
      return null;
    }
    final day = int.tryParse(parts[0]);
    final month = int.tryParse(parts[1]);
    final year = int.tryParse(parts[2]);
    if (day == null || month == null || year == null) {
      return null;
    }
    return DateTime(year, month, day);
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
