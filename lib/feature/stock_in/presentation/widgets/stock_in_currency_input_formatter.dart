import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

import 'package:store_manage/core/constants/app_strings.dart';

class StockInCurrencyInputFormatter extends TextInputFormatter {
  StockInCurrencyInputFormatter({NumberFormat? numberFormat})
    : _numberFormat = numberFormat ?? NumberFormat.decimalPattern(AppStrings.VIET_NAM_LOCALE);

  final NumberFormat _numberFormat;

  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    final digits = newValue.text.replaceAll(RegExp(r'[^0-9]'), '');
    if (digits.isEmpty) {
      return const TextEditingValue(text: '');
    }

    final value = int.tryParse(digits) ?? 0;
    final formatted = _numberFormat.format(value);
    final text = '$formatted ${AppStrings.VIET_NAM_DONG_TEXT}';

    return TextEditingValue(
      text: text,
      selection: TextSelection.collapsed(offset: text.length),
    );
  }
}
