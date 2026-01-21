import 'package:flutter/material.dart';

import 'package:store_manage/core/constants/app_colors.dart';
import 'package:store_manage/core/constants/app_font_sizes.dart';
import 'package:store_manage/core/constants/app_fonts.dart';
import 'package:store_manage/core/constants/app_numbers.dart';

class AppPageHeader extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final List<Widget>? actions;

  const AppPageHeader({super.key, required this.title, this.actions});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: AppColors.background,
      elevation: AppNumbers.DOUBLE_0,
      scrolledUnderElevation: AppNumbers.DOUBLE_0,
      surfaceTintColor: AppColors.background,
      title: Text(
        title,
        style: const TextStyle(
          fontSize: AppFontSizes.fontSize18,
          fontWeight: FontWeight.w600,
          fontFamily: AppFonts.inter,
          color: AppColors.textPrimary,
        ),
      ),
      actions: actions,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
