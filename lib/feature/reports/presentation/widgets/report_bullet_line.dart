import 'package:flutter/material.dart';

import 'package:store_manage/core/constants/app_colors.dart';
import 'package:store_manage/core/constants/app_numbers.dart';
import 'package:store_manage/core/constants/app_strings.dart';

class ReportBulletLine extends StatelessWidget {
  final String text;

  const ReportBulletLine({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Padding(
      padding: const EdgeInsets.only(bottom: AppNumbers.DOUBLE_6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(AppStrings.reportBulletPrefix, style: textTheme.bodySmall?.copyWith(color: AppColors.textSecondary)),
          Expanded(
            child: Text(text, style: textTheme.labelMedium),
          ),
        ],
      ),
    );
  }
}
