import 'package:flutter/material.dart';

import 'package:store_manage/core/constants/app_colors.dart';
import 'package:store_manage/core/constants/app_font_sizes.dart';
import 'package:store_manage/core/constants/app_fonts.dart';
import 'package:store_manage/core/constants/app_numbers.dart';
import 'package:store_manage/core/constants/app_strings.dart';

class ReportBulletLine extends StatelessWidget {
  final String text;

  const ReportBulletLine({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: AppNumbers.DOUBLE_6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(AppStrings.reportBulletPrefix, style: TextStyle(color: AppColors.textSecondary)),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(
                fontSize: AppFontSizes.fontSize12,
                fontWeight: FontWeight.w500,
                fontFamily: AppFonts.inter,
                color: AppColors.textSecondary,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
