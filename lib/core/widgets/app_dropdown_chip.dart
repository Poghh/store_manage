import 'package:flutter/material.dart';

import 'package:store_manage/core/constants/app_colors.dart';
import 'package:store_manage/core/constants/app_font_sizes.dart';
import 'package:store_manage/core/constants/app_fonts.dart';
import 'package:store_manage/core/constants/app_numbers.dart';

class AppDropdownChip extends StatelessWidget {
  final String label;
  final Color backgroundColor;
  final Color borderColor;
  final Color textColor;
  final Color iconColor;
  final double borderRadius;
  final EdgeInsetsGeometry padding;
  final double fontSize;
  final FontWeight fontWeight;
  final IconData trailingIcon;

  const AppDropdownChip({
    super.key,
    required this.label,
    this.backgroundColor = AppColors.surfaceMuted,
    this.borderColor = AppColors.borderStrong,
    this.textColor = AppColors.textPrimary,
    this.iconColor = AppColors.textSecondary,
    this.borderRadius = AppNumbers.DOUBLE_20,
    this.padding = const EdgeInsets.symmetric(horizontal: AppNumbers.DOUBLE_10, vertical: AppNumbers.DOUBLE_6),
    this.fontSize = AppFontSizes.fontSize14,
    this.fontWeight = FontWeight.w600,
    this.trailingIcon = Icons.keyboard_arrow_down,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding,
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(borderRadius),
        border: Border.all(color: borderColor),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            label,
            style: TextStyle(fontSize: fontSize, fontWeight: fontWeight, fontFamily: AppFonts.inter, color: textColor),
          ),
          const SizedBox(width: AppNumbers.DOUBLE_4),
          Icon(trailingIcon, color: iconColor, size: AppNumbers.DOUBLE_18),
        ],
      ),
    );
  }
}
