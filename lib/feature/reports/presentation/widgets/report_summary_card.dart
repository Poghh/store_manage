import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:store_manage/core/constants/app_colors.dart';
import 'package:store_manage/core/constants/app_font_sizes.dart';
import 'package:store_manage/core/constants/app_fonts.dart';
import 'package:store_manage/core/constants/app_numbers.dart';
import 'package:store_manage/core/constants/app_strings.dart';
import 'package:store_manage/core/utils/common_funtion_utils.dart';
import 'package:store_manage/core/widgets/app_surface_card.dart';

class ReportSummaryCard extends StatelessWidget {
  final DateTime date;
  final int totalRevenue;
  final double growthValue;
  final String growthLabel;

  const ReportSummaryCard({
    super.key,
    required this.date,
    required this.totalRevenue,
    required this.growthValue,
    required this.growthLabel,
  });

  @override
  Widget build(BuildContext context) {
    return AppSurfaceCard(
      padding: const EdgeInsets.all(AppNumbers.DOUBLE_16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            AppStrings.reportSummaryTitle,
            style: TextStyle(
              fontSize: AppFontSizes.fontSize14,
              fontWeight: FontWeight.w700,
              fontFamily: AppFonts.inter,
              color: AppColors.textPrimary,
            ),
          ),
          const SizedBox(height: AppNumbers.DOUBLE_8),
          Text(
            DateFormat('dd/MM/yyyy').format(date),
            style: const TextStyle(
              fontSize: AppFontSizes.fontSize12,
              fontWeight: FontWeight.w500,
              fontFamily: AppFonts.inter,
              color: AppColors.textSecondary,
            ),
          ),
          const SizedBox(height: AppNumbers.DOUBLE_12),
          Row(
            children: [
              const Icon(Icons.assessment_outlined, color: AppColors.primary),
              const SizedBox(width: AppNumbers.DOUBLE_8),
              Text(
                CommonFuntionUtils.formatCurrency(totalRevenue),
                style: const TextStyle(
                  fontSize: AppFontSizes.fontSize20,
                  fontWeight: FontWeight.w700,
                  fontFamily: AppFonts.inter,
                  color: AppColors.textPrimary,
                ),
              ),
              const Spacer(),
              Text(
                growthLabel,
                style: TextStyle(
                  fontSize: AppFontSizes.fontSize12,
                  fontWeight: FontWeight.w600,
                  fontFamily: AppFonts.inter,
                  color: growthValue >= 0 ? AppColors.primary : Colors.redAccent,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
