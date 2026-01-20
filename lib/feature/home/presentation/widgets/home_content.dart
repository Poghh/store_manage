import 'package:flutter/material.dart';

import 'package:store_manage/core/constants/app_colors.dart';
import 'package:store_manage/core/constants/app_numbers.dart';
import 'package:store_manage/core/constants/app_strings.dart';
import 'package:store_manage/feature/home/presentation/widgets/revenue_summary_card.dart';

class HomeContent extends StatelessWidget {
  const HomeContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.background,
      child: Padding(
        padding: const EdgeInsets.all(AppNumbers.DOUBLE_16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                RichText(
                  text: TextSpan(
                    style: Theme.of(context).textTheme.bodyMedium,
                    children: [
                      TextSpan(
                        text: AppStrings.homeGreetingPrefix,
                        style: TextStyle(color: AppColors.textSecondary),
                      ),
                      TextSpan(
                        text: AppStrings.homeGreetingName,
                        style: TextStyle(color: AppColors.textPrimary, fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: AppNumbers.DOUBLE_4),
                Row(
                  children: [
                    Material(
                      color: AppColors.surface.withValues(alpha: 0),
                      child: InkWell(
                        onTap: () {},
                        borderRadius: BorderRadius.circular(AppNumbers.DOUBLE_16),
                        child: Icon(
                          Icons.arrow_circle_left,
                          size: AppNumbers.DOUBLE_16,
                          color: AppColors.textSecondary,
                        ),
                      ),
                    ),
                    const SizedBox(width: AppNumbers.DOUBLE_4),
                    Text(
                      AppStrings.homeDateDisplay,
                      style: Theme.of(context).textTheme.bodySmall!.copyWith(color: AppColors.textSecondary),
                    ),
                    const SizedBox(width: AppNumbers.DOUBLE_4),
                    Material(
                      color: AppColors.surface.withValues(alpha: 0),
                      child: InkWell(
                        onTap: () {},
                        borderRadius: BorderRadius.circular(AppNumbers.DOUBLE_16),
                        child: Icon(
                          Icons.arrow_circle_right,
                          size: AppNumbers.DOUBLE_16,
                          color: AppColors.textSecondary,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: AppNumbers.DOUBLE_16),
            RevenueSummaryCard(),
          ],
        ),
      ),
    );
  }
}
