import 'package:flutter/material.dart';

import 'package:store_manage/core/constants/app_colors.dart';
import 'package:store_manage/core/constants/app_font_sizes.dart';
import 'package:store_manage/core/constants/app_fonts.dart';

class StockInFieldLabel extends StatelessWidget {
  final String text;

  const StockInFieldLabel({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: const TextStyle(
        fontSize: AppFontSizes.fontSize14,
        fontWeight: FontWeight.w600,
        fontFamily: AppFonts.inter,
        color: AppColors.textSecondary,
      ),
    );
  }
}
