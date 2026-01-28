import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:store_manage/core/constants/app_colors.dart';
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
    final textTheme = Theme.of(context).textTheme;
    final today = DateTime.now();
    final yesterday = today.subtract(const Duration(days: 1));

    return AppSurfaceCard(
      padding: EdgeInsets.all(AppNumbers.DOUBLE_16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            AppStrings.reportSummaryTitle,
            style: textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w700),
          ),
          SizedBox(height: AppNumbers.DOUBLE_16),
          _buildRevenueRow(
            context: context,
            label: AppStrings.reportTodayLabel,
            date: today,
            revenue: todayRevenue,
            showGrowth: true,
          ),
          SizedBox(height: AppNumbers.DOUBLE_12),
          _buildRevenueRow(
            context: context,
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
    required BuildContext context,
    required String label,
    required DateTime date,
    required int revenue,
    required bool showGrowth,
  }) {
    final textTheme = Theme.of(context).textTheme;

    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(label, style: textTheme.labelMedium),
              SizedBox(height: AppNumbers.DOUBLE_4),
              Text(DateFormat('dd/MM/yyyy').format(date), style: textTheme.labelSmall),
            ],
          ),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              CommonFuntionUtils.formatCurrency(revenue),
              style: textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w700),
            ),
            if (showGrowth) ...[
              SizedBox(height: AppNumbers.DOUBLE_4),
              Text(
                AppStrings.reportGrowthLabel(growthPercentage),
                style: textTheme.labelSmall?.copyWith(
                  fontWeight: FontWeight.w600,
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
