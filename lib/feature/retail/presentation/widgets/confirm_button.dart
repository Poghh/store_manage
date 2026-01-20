import 'package:flutter/material.dart';

import 'package:store_manage/core/constants/app_colors.dart';
import 'package:store_manage/core/constants/app_font_sizes.dart';
import 'package:store_manage/core/constants/app_fonts.dart';
import 'package:store_manage/core/constants/app_numbers.dart';
import 'package:store_manage/core/constants/app_strings.dart';

class ConfirmButton extends StatelessWidget {
  final VoidCallback? onPressed;

  const ConfirmButton({super.key, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: AppNumbers.DOUBLE_48,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primaryDark,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppNumbers.DOUBLE_12)),
        ),
        child: const Text(
          AppStrings.retailConfirmButton,
          style: TextStyle(
            fontSize: AppFontSizes.fontSize14,
            fontWeight: FontWeight.w700,
            fontFamily: AppFonts.inter,
            color: AppColors.textOnPrimary,
          ),
        ),
      ),
    );
  }
}
