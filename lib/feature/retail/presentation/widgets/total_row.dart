import 'package:flutter/material.dart';

import 'package:store_manage/core/constants/app_colors.dart';
import 'package:store_manage/core/constants/app_font_sizes.dart';
import 'package:store_manage/core/constants/app_fonts.dart';
import 'package:store_manage/core/constants/app_strings.dart';
import 'package:store_manage/core/utils/common_funtion_utils.dart';

class TotalRow extends StatelessWidget {
  final int total;

  const TotalRow({super.key, required this.total});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Text(
          AppStrings.retailTotalLabel,
          style: TextStyle(
            fontSize: AppFontSizes.fontSize14,
            fontWeight: FontWeight.w600,
            fontFamily: AppFonts.inter,
            color: AppColors.textOnPrimary,
          ),
        ),
        const Spacer(),
        Text(
          CommonFuntionUtils.formatCurrency(total),
          style: const TextStyle(
            fontSize: AppFontSizes.fontSize16,
            fontWeight: FontWeight.w700,
            fontFamily: AppFonts.inter,
            color: AppColors.textOnPrimary,
          ),
        ),
      ],
    );
  }
}
