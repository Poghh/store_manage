import 'package:flutter/material.dart';

import 'package:store_manage/core/constants/app_colors.dart';
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
    final textTheme = Theme.of(context).textTheme;
    return AppSurfaceCard(
      padding: const EdgeInsets.all(AppNumbers.DOUBLE_16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.auto_awesome, color: AppColors.primary),
              const SizedBox(width: AppNumbers.DOUBLE_8),
              Text(AppStrings.reportAiTitle, style: textTheme.titleSmall),
            ],
          ),
          const SizedBox(height: AppNumbers.DOUBLE_12),
          ...insights.map((item) => ReportBulletLine(text: item)),
          const SizedBox(height: AppNumbers.DOUBLE_12),
          Text(AppStrings.reportSuggestionTitle, style: textTheme.labelMedium),
          const SizedBox(height: AppNumbers.DOUBLE_8),
          ...suggestions.map((item) => ReportBulletLine(text: item)),
        ],
      ),
    );
  }
}
