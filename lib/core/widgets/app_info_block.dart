import 'package:flutter/material.dart';

import 'package:store_manage/core/constants/app_colors.dart';
import 'package:store_manage/core/constants/app_font_sizes.dart';
import 'package:store_manage/core/constants/app_fonts.dart';
import 'package:store_manage/core/constants/app_numbers.dart';

class AppInfoBlock extends StatelessWidget {
  final String label;
  final String value;
  final Color labelColor;
  final Color valueColor;
  final double labelFontSize;
  final double valueFontSize;
  final FontWeight labelWeight;
  final FontWeight valueWeight;
  final double spacing;
  final int valueMaxLines;

  const AppInfoBlock({
    super.key,
    required this.label,
    required this.value,
    this.labelColor = AppColors.textSecondary,
    this.valueColor = AppColors.textPrimary,
    this.labelFontSize = AppFontSizes.fontSize12,
    this.valueFontSize = AppFontSizes.fontSize12,
    this.labelWeight = FontWeight.w500,
    this.valueWeight = FontWeight.w700,
    this.spacing = AppNumbers.DOUBLE_4,
    this.valueMaxLines = 1,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: labelFontSize,
            fontWeight: labelWeight,
            fontFamily: AppFonts.inter,
            color: labelColor,
          ),
        ),
        SizedBox(height: spacing),
        Text(
          value,
          style: TextStyle(
            fontSize: valueFontSize,
            fontWeight: valueWeight,
            fontFamily: AppFonts.inter,
            color: valueColor,
          ),
          maxLines: valueMaxLines,
          overflow: TextOverflow.ellipsis,
        ),
      ],
    );
  }
}
