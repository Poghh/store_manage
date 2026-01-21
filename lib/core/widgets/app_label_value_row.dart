import 'package:flutter/material.dart';

import 'package:store_manage/core/constants/app_colors.dart';
import 'package:store_manage/core/constants/app_font_sizes.dart';
import 'package:store_manage/core/constants/app_fonts.dart';
import 'package:store_manage/core/constants/app_numbers.dart';

class AppLabelValueRow extends StatelessWidget {
  final String label;
  final String value;
  final Widget? leading;
  final double leadingSpacing;
  final Color labelColor;
  final Color valueColor;
  final double labelFontSize;
  final double valueFontSize;
  final FontWeight labelWeight;
  final FontWeight valueWeight;

  const AppLabelValueRow({
    super.key,
    required this.label,
    required this.value,
    this.leading,
    this.leadingSpacing = AppNumbers.DOUBLE_8,
    this.labelColor = AppColors.textSecondary,
    this.valueColor = AppColors.textPrimary,
    this.labelFontSize = AppFontSizes.fontSize12,
    this.valueFontSize = AppFontSizes.fontSize14,
    this.labelWeight = FontWeight.w600,
    this.valueWeight = FontWeight.w700,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        if (leading != null) leading!,
        if (leading != null) SizedBox(width: leadingSpacing),
        Text(
          label,
          style: TextStyle(
            fontSize: labelFontSize,
            fontWeight: labelWeight,
            fontFamily: AppFonts.inter,
            color: labelColor,
          ),
        ),
        const Spacer(),
        Text(
          value,
          style: TextStyle(
            fontSize: valueFontSize,
            fontWeight: valueWeight,
            fontFamily: AppFonts.inter,
            color: valueColor,
          ),
        ),
      ],
    );
  }
}
