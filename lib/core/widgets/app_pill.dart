import 'package:flutter/material.dart';

import 'package:store_manage/core/constants/app_colors.dart';
import 'package:store_manage/core/constants/app_font_sizes.dart';
import 'package:store_manage/core/constants/app_fonts.dart';
import 'package:store_manage/core/constants/app_numbers.dart';

class AppPill extends StatelessWidget {
  final String text;
  final EdgeInsetsGeometry padding;
  final Color backgroundColor;
  final Color textColor;
  final double borderRadius;
  final double fontSize;
  final FontWeight fontWeight;

  const AppPill({
    super.key,
    required this.text,
    this.padding = const EdgeInsets.symmetric(horizontal: AppNumbers.DOUBLE_8, vertical: AppNumbers.DOUBLE_2),
    this.backgroundColor = AppColors.primaryLight,
    this.textColor = AppColors.primary,
    this.borderRadius = AppNumbers.DOUBLE_8,
    this.fontSize = AppFontSizes.fontSize12,
    this.fontWeight = FontWeight.w700,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding,
      decoration: BoxDecoration(color: backgroundColor, borderRadius: BorderRadius.circular(borderRadius)),
      child: Text(
        text,
        style: TextStyle(fontSize: fontSize, fontWeight: fontWeight, fontFamily: AppFonts.inter, color: textColor),
      ),
    );
  }
}
