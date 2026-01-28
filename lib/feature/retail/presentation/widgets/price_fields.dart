import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

import 'package:store_manage/core/constants/app_colors.dart';
import 'package:store_manage/core/constants/app_numbers.dart';
import 'package:store_manage/core/constants/app_strings.dart';
import 'package:store_manage/core/utils/common_funtion_utils.dart';
import 'package:store_manage/core/widgets/app_field_container.dart';
import 'package:store_manage/feature/retail/presentation/widgets/retail_currency_input_formatter.dart';

class PriceField extends StatelessWidget {
  final TextEditingController controller;
  final ValueChanged<String> onChanged;

  const PriceField({super.key, required this.controller, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return AppFieldContainer(
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: controller,
              onChanged: onChanged,
              keyboardType: TextInputType.number,
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
                RetailCurrencyInputFormatter(numberFormat: NumberFormat.decimalPattern(AppStrings.VIET_NAM_LOCALE)),
              ],
              decoration: InputDecoration(
                border: InputBorder.none,
                isDense: true,
                hintText: AppStrings.retailPriceHint,
                hintStyle: textTheme.labelLarge?.copyWith(color: AppColors.textMuted),
                suffixText: AppStrings.VIET_NAM_DONG_TEXT,
                suffixStyle: textTheme.titleSmall?.copyWith(color: AppColors.textMuted),
              ),
              style: textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w700),
            ),
          ),
          const Icon(Icons.edit, color: AppColors.primary, size: AppNumbers.DOUBLE_18),
        ],
      ),
    );
  }
}

class DisabledPriceField extends StatelessWidget {
  final int value;

  const DisabledPriceField({super.key, required this.value});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return AppFieldContainer(
      backgroundColor: AppColors.surfaceMuted,
      child: Row(
        children: [
          Expanded(
            child: Text(
              value > 0 ? CommonFuntionUtils.formatCurrency(value) : AppStrings.stockInPriceHint,
              style: textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w700,
                color: value > 0 ? AppColors.textPrimary : AppColors.textMuted,
              ),
            ),
          ),
          const Icon(Icons.lock_outline, color: AppColors.textMuted, size: AppNumbers.DOUBLE_18),
        ],
      ),
    );
  }
}
