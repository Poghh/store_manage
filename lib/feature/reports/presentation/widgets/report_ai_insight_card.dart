import 'package:flutter/material.dart';

import 'package:store_manage/core/constants/app_colors.dart';
import 'package:store_manage/core/constants/app_font_sizes.dart';
import 'package:store_manage/core/constants/app_fonts.dart';
import 'package:store_manage/core/constants/app_numbers.dart';
import 'package:store_manage/core/constants/app_strings.dart';
import 'package:store_manage/core/widgets/app_surface_card.dart';
import 'package:store_manage/feature/reports/presentation/widgets/report_bullet_line.dart';

class ReportAiInsightCard extends StatelessWidget {
  final List<String> insights;
  final List<String> suggestions;

  const ReportAiInsightCard({super.key, required this.insights, required this.suggestions});

  @override
  Widget build(BuildContext context) {
    return AppSurfaceCard(
      padding: const EdgeInsets.all(AppNumbers.DOUBLE_16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Row(
            children: [
              Icon(Icons.auto_awesome, color: AppColors.primary),
              SizedBox(width: AppNumbers.DOUBLE_8),
              Text(
                AppStrings.reportAiTitle,
                style: TextStyle(
                  fontSize: AppFontSizes.fontSize14,
                  fontWeight: FontWeight.w700,
                  fontFamily: AppFonts.inter,
                  color: AppColors.textPrimary,
                ),
              ),
            ],
          ),
          const SizedBox(height: AppNumbers.DOUBLE_12),
          ...insights.map((item) => ReportBulletLine(text: item)).toList(),
          const SizedBox(height: AppNumbers.DOUBLE_12),
          const Text(
            AppStrings.reportSuggestionTitle,
            style: TextStyle(
              fontSize: AppFontSizes.fontSize12,
              fontWeight: FontWeight.w700,
              fontFamily: AppFonts.inter,
              color: AppColors.textSecondary,
            ),
          ),
          const SizedBox(height: AppNumbers.DOUBLE_8),
          ...suggestions.map((item) => ReportBulletLine(text: item)).toList(),
        ],
      ),
    );
  }
}
