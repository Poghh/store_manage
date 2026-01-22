import 'package:store_manage/core/constants/app_strings.dart';
import 'package:store_manage/core/utils/common_funtion_utils.dart';

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
    final parsed = CommonFuntionUtils.parseDigitsToInt(value);
    if (parsed == null || parsed <= 0) {
      return AppStrings.stockInValidationPositiveNumber;
    }
    return null;
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
