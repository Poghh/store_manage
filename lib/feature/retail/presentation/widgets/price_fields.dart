import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

import 'package:store_manage/core/constants/app_colors.dart';
import 'package:store_manage/core/constants/app_font_sizes.dart';
import 'package:store_manage/core/constants/app_fonts.dart';
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
              decoration: const InputDecoration(
                border: InputBorder.none,
                isDense: true,
                hintText: AppStrings.retailPriceHint,
                hintStyle: TextStyle(
                  fontSize: AppFontSizes.fontSize14,
                  fontWeight: FontWeight.w500,
                  fontFamily: AppFonts.inter,
                  color: AppColors.textMuted,
                ),
                suffixText: AppStrings.VIET_NAM_DONG_TEXT,
                suffixStyle: TextStyle(
                  fontSize: AppFontSizes.fontSize14,
                  fontWeight: FontWeight.w600,
                  fontFamily: AppFonts.inter,
                  color: AppColors.textMuted,
                ),
              ),
              style: const TextStyle(
                fontSize: AppFontSizes.fontSize16,
                fontWeight: FontWeight.w700,
                fontFamily: AppFonts.inter,
                color: AppColors.textPrimary,
              ),
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
    return AppFieldContainer(
      backgroundColor: AppColors.surfaceMuted,
      child: Row(
        children: [
          Expanded(
            child: Text(
              value > 0 ? CommonFuntionUtils.formatCurrency(value) : AppStrings.stockInPriceHint,
              style: TextStyle(
                fontSize: AppFontSizes.fontSize16,
                fontWeight: FontWeight.w700,
                fontFamily: AppFonts.inter,
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
