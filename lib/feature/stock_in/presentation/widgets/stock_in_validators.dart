import 'package:store_manage/core/constants/app_strings.dart';

class StockInValidators {
  static String? requiredField(String? value) {
    if (value == null || value.trim().isEmpty) {
      return AppStrings.stockInValidationRequired;
    }
    return null;
  }

  static String? positiveInt(String? value) {
    if (value == null || value.trim().isEmpty) {
      return AppStrings.stockInValidationRequired;
    }
    final parsed = int.tryParse(value.trim());
    if (parsed == null || parsed <= 0) {
      return AppStrings.stockInValidationPositiveInteger;
    }
    return null;
  }

  static String? positiveNumber(String? value) {
    if (value == null || value.trim().isEmpty) {
      return AppStrings.stockInValidationRequired;
    }
    final parsed = _parseDigits(value);
    if (parsed == null || parsed <= 0) {
      return AppStrings.stockInValidationPositiveNumber;
    }
    return null;
  }

  static int? _parseDigits(String value) {
    final digits = value.replaceAll(RegExp(r'[^0-9]'), '');
    if (digits.isEmpty) {
      return null;
    }
    return int.tryParse(digits);
  }

  static String? dateNotFuture(DateTime? value) {
    if (value == null) {
      return AppStrings.stockInValidationRequired;
    }
    final today = DateTime.now();
    final selected = DateTime(value.year, value.month, value.day);
    final now = DateTime(today.year, today.month, today.day);
    if (selected.isAfter(now)) {
      return AppStrings.stockInValidationFutureDate;
    }
    return null;
  }
}
