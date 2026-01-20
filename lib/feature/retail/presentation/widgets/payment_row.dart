import 'package:flutter/material.dart';

import 'package:store_manage/core/constants/app_colors.dart';
import 'package:store_manage/core/constants/app_font_sizes.dart';
import 'package:store_manage/core/constants/app_fonts.dart';
import 'package:store_manage/core/constants/app_numbers.dart';
import 'package:store_manage/core/constants/app_strings.dart';
import 'package:store_manage/core/utils/common_funtion_utils.dart';
import 'package:store_manage/feature/retail/presentation/widgets/payment_method.dart';

class PaymentRow extends StatelessWidget {
  final int total;
  final String methodLabel;
  final PaymentMethod value;
  final ValueChanged<PaymentMethod> onChanged;

  const PaymentRow({
    super.key,
    required this.total,
    required this.methodLabel,
    required this.value,
    required this.onChanged,
  });

  String _labelFor(PaymentMethod method) {
    switch (method) {
      case PaymentMethod.cash:
        return AppStrings.retailCashLabel;
      case PaymentMethod.transfer:
        return AppStrings.retailTransferLabel;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: AppNumbers.DOUBLE_12, vertical: AppNumbers.DOUBLE_10),
      decoration: BoxDecoration(color: AppColors.surface, borderRadius: BorderRadius.circular(AppNumbers.DOUBLE_12)),
      child: Row(
        children: [
          PopupMenuButton<PaymentMethod>(
            onSelected: onChanged,
            color: AppColors.surface,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppNumbers.DOUBLE_12)),
            itemBuilder: (context) => PaymentMethod.values
                .map((method) => PopupMenuItem<PaymentMethod>(value: method, child: Text(_labelFor(method))))
                .toList(),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: AppNumbers.DOUBLE_10, vertical: AppNumbers.DOUBLE_6),
              decoration: BoxDecoration(
                color: AppColors.surfaceMuted,
                borderRadius: BorderRadius.circular(AppNumbers.DOUBLE_20),
                border: Border.all(color: AppColors.borderStrong),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    methodLabel,
                    style: const TextStyle(
                      fontSize: AppFontSizes.fontSize14,
                      fontWeight: FontWeight.w600,
                      fontFamily: AppFonts.inter,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  const SizedBox(width: AppNumbers.DOUBLE_4),
                  const Icon(Icons.keyboard_arrow_down, color: AppColors.textSecondary, size: AppNumbers.DOUBLE_18),
                ],
              ),
            ),
          ),
          const Spacer(),
          Text(
            CommonFuntionUtils.formatCurrency(total),
            style: const TextStyle(
              fontSize: AppFontSizes.fontSize14,
              fontWeight: FontWeight.w700,
              fontFamily: AppFonts.inter,
              color: AppColors.textPrimary,
            ),
          ),
        ],
      ),
    );
  }
}
