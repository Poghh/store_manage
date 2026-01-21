import 'package:flutter/material.dart';

import 'package:store_manage/core/constants/app_colors.dart';
import 'package:store_manage/core/constants/app_font_sizes.dart';
import 'package:store_manage/core/constants/app_fonts.dart';
import 'package:store_manage/core/constants/app_numbers.dart';

class AppInfoRow extends StatelessWidget {
  final String label;
  final String value;
  final double labelWidth;
  final Color labelColor;
  final Color valueColor;
  final double labelFontSize;
  final double valueFontSize;
  final FontWeight labelWeight;
  final FontWeight valueWeight;

  const AppInfoRow({
    super.key,
    required this.label,
    required this.value,
    this.labelWidth = AppNumbers.DOUBLE_120,
    this.labelColor = AppColors.textSecondary,
    this.valueColor = AppColors.textPrimary,
    this.labelFontSize = AppFontSizes.fontSize14,
    this.valueFontSize = AppFontSizes.fontSize14,
    this.labelWeight = FontWeight.w500,
    this.valueWeight = FontWeight.w600,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: AppNumbers.DOUBLE_10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: labelWidth,
            child: Text(
              label,
              style: TextStyle(
                fontSize: labelFontSize,
                fontWeight: labelWeight,
                fontFamily: AppFonts.inter,
                color: labelColor,
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: TextStyle(
                fontSize: valueFontSize,
                fontWeight: valueWeight,
                fontFamily: AppFonts.inter,
                color: valueColor,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
