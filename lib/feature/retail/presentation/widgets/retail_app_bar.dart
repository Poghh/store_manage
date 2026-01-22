import 'package:flutter/material.dart';

import 'package:store_manage/core/constants/app_colors.dart';
import 'package:store_manage/core/constants/app_font_sizes.dart';
import 'package:store_manage/core/constants/app_fonts.dart';
import 'package:store_manage/core/constants/app_numbers.dart';
import 'package:store_manage/core/constants/app_strings.dart';

class RetailAppBar extends StatelessWidget implements PreferredSizeWidget {
  final VoidCallback onBack;

  const RetailAppBar({super.key, required this.onBack});

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: AppColors.primary,
      elevation: AppNumbers.DOUBLE_0,
      scrolledUnderElevation: AppNumbers.DOUBLE_0,
      surfaceTintColor: AppColors.primary,
      leading: IconButton(
        onPressed: onBack,
        icon: const Icon(Icons.arrow_back, color: AppColors.textOnPrimary),
      ),
      title: const Text(
        AppStrings.retailTitle,
        style: TextStyle(
          fontSize: AppFontSizes.fontSize18,
          fontWeight: FontWeight.w600,
          fontFamily: AppFonts.inter,
          color: AppColors.textOnPrimary,
        ),
      ),
      actions: const [
        Padding(
          padding: EdgeInsets.only(right: AppNumbers.DOUBLE_12),
          child: Icon(Icons.local_offer_outlined, color: AppColors.textOnPrimary),
        ),
      ],
    );
  }
}
