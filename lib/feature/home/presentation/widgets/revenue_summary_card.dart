import 'package:flutter/material.dart';

import 'package:store_manage/core/constants/app_colors.dart';
import 'package:store_manage/core/constants/app_font_sizes.dart';
import 'package:store_manage/core/constants/app_fonts.dart';
import 'package:store_manage/core/constants/app_numbers.dart';
import 'package:store_manage/core/constants/app_strings.dart';

class RevenueSummaryCard extends StatelessWidget {
  const RevenueSummaryCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppNumbers.DOUBLE_16),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(AppNumbers.DOUBLE_12),
        border: Border.all(color: AppColors.border),
        boxShadow: const [
          BoxShadow(
            color: AppColors.border,
            blurRadius: AppNumbers.DOUBLE_8,
            offset: Offset(AppNumbers.DOUBLE_0, AppNumbers.DOUBLE_4),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  AppStrings.todayRevenueLabel,
                  style: TextStyle(
                    fontSize: AppFontSizes.fontSize22,
                    fontWeight: FontWeight.w500,
                    fontFamily: AppFonts.inter,
                    color: AppColors.primaryDark,
                  ),
                ),
                const SizedBox(height: AppNumbers.DOUBLE_8),
                Text(
                  AppStrings.todayRevenueValue,
                  style: TextStyle(
                    fontSize: AppFontSizes.fontSize22,
                    fontWeight: FontWeight.w700,
                    fontFamily: AppFonts.inter,
                    color: AppColors.primaryDark,
                  ),
                ),
              ],
            ),
          ),
          Container(
            height: AppNumbers.DOUBLE_65,
            width: AppNumbers.DOUBLE_65,
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(AppNumbers.DOUBLE_12)),
            child: Icon(Icons.account_balance_wallet_outlined, size: AppNumbers.DOUBLE_60, color: AppColors.primary),
          ),
        ],
      ),
    );
  }
}
