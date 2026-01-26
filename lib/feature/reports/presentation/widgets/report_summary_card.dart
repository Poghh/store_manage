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
  final int todayRevenue;
  final int yesterdayRevenue;
  final double growthPercentage;

  const ReportSummaryCard({
    super.key,
    required this.todayRevenue,
    required this.yesterdayRevenue,
    required this.growthPercentage,
  });

  @override
  Widget build(BuildContext context) {
    final today = DateTime.now();
    final yesterday = today.subtract(const Duration(days: 1));

    return AppSurfaceCard(
      padding: EdgeInsets.all(AppNumbers.DOUBLE_16),
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
          SizedBox(height: AppNumbers.DOUBLE_16),
          _buildRevenueRow(
            label: AppStrings.reportTodayLabel,
            date: today,
            revenue: todayRevenue,
            showGrowth: true,
          ),
          SizedBox(height: AppNumbers.DOUBLE_12),
          _buildRevenueRow(
            label: AppStrings.reportYesterdayLabel,
            date: yesterday,
            revenue: yesterdayRevenue,
            showGrowth: false,
          ),
        ],
      ),
    );
  }

  Widget _buildRevenueRow({
    required String label,
    required DateTime date,
    required int revenue,
    required bool showGrowth,
  }) {
    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: const TextStyle(
                  fontSize: AppFontSizes.fontSize12,
                  fontWeight: FontWeight.w500,
                  fontFamily: AppFonts.inter,
                  color: AppColors.textSecondary,
                ),
              ),
              SizedBox(height: AppNumbers.DOUBLE_4),
              Text(
                DateFormat('dd/MM/yyyy').format(date),
                style: TextStyle(
                  fontSize: AppFontSizes.fontSize10,
                  fontFamily: AppFonts.inter,
                  color: AppColors.textMuted,
                ),
              ),
            ],
          ),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              CommonFuntionUtils.formatCurrency(revenue),
              style: const TextStyle(
                fontSize: AppFontSizes.fontSize16,
                fontWeight: FontWeight.w700,
                fontFamily: AppFonts.inter,
                color: AppColors.textPrimary,
              ),
            ),
            if (showGrowth) ...[
              SizedBox(height: AppNumbers.DOUBLE_4),
              Text(
                AppStrings.reportGrowthLabel(growthPercentage),
                style: TextStyle(
                  fontSize: AppFontSizes.fontSize10,
                  fontWeight: FontWeight.w600,
                  fontFamily: AppFonts.inter,
                  color: growthPercentage >= 0 ? AppColors.primary : Colors.redAccent,
                ),
              ),
            ],
          ],
        ),
      ],
    );
  }
}
