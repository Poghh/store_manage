import 'package:flutter/material.dart';

import 'package:store_manage/core/constants/app_colors.dart';
import 'package:store_manage/core/constants/app_font_sizes.dart';
import 'package:store_manage/core/constants/app_fonts.dart';

class AppSectionLabel extends StatelessWidget {
  final String text;
  final Color color;
  final double fontSize;
  final FontWeight fontWeight;

  const AppSectionLabel({
    super.key,
    required this.text,
    this.color = AppColors.textSecondary,
    this.fontSize = AppFontSizes.fontSize14,
    this.fontWeight = FontWeight.w600,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(fontSize: fontSize, fontWeight: fontWeight, fontFamily: AppFonts.inter, color: color),
    );
  }
}
