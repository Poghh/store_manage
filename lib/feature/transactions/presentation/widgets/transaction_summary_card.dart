import 'package:flutter/material.dart';

import 'package:store_manage/core/constants/app_colors.dart';
import 'package:store_manage/core/constants/app_font_sizes.dart';
import 'package:store_manage/core/constants/app_numbers.dart';
import 'package:store_manage/core/constants/app_strings.dart';
import 'package:store_manage/core/widgets/app_label_value_row.dart';
import 'package:store_manage/core/widgets/app_surface_card.dart';
import 'package:store_manage/core/utils/common_funtion_utils.dart';

class TransactionSummaryCard extends StatelessWidget {
  final int totalRevenue;

  const TransactionSummaryCard({super.key, required this.totalRevenue});

  @override
  Widget build(BuildContext context) {
    return AppSurfaceCard(
      margin: const EdgeInsets.fromLTRB(
        AppNumbers.DOUBLE_12,
        AppNumbers.DOUBLE_12,
        AppNumbers.DOUBLE_12,
        AppNumbers.DOUBLE_4,
      ),
      backgroundColor: AppColors.background,
      child: AppLabelValueRow(
        label: AppStrings.transactionsTotalRevenueLabel,
        value: CommonFuntionUtils.formatCurrency(totalRevenue),
        leading: const Icon(Icons.assessment_outlined, color: AppColors.primary),
        labelColor: AppColors.textSecondary,
        valueColor: AppColors.textPrimary,
        labelFontSize: AppFontSizes.fontSize12,
        valueFontSize: AppFontSizes.fontSize14,
      ),
    );
  }
}
