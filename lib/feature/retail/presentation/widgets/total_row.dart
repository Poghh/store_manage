import 'package:flutter/material.dart';

import 'package:store_manage/core/constants/app_colors.dart';
import 'package:store_manage/core/constants/app_font_sizes.dart';
import 'package:store_manage/core/constants/app_strings.dart';
import 'package:store_manage/core/utils/common_funtion_utils.dart';
import 'package:store_manage/core/widgets/app_label_value_row.dart';

class TotalRow extends StatelessWidget {
  final int total;

  const TotalRow({super.key, required this.total});

  @override
  Widget build(BuildContext context) {
    return AppLabelValueRow(
      label: AppStrings.retailTotalLabel,
      value: CommonFuntionUtils.formatCurrency(total),
      labelColor: AppColors.textOnPrimary,
      valueColor: AppColors.textOnPrimary,
      labelFontSize: AppFontSizes.fontSize14,
      valueFontSize: AppFontSizes.fontSize16,
    );
  }
}
