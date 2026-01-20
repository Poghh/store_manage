import 'package:flutter/material.dart';

import 'package:store_manage/core/constants/app_colors.dart';
import 'package:store_manage/core/constants/app_font_sizes.dart';
import 'package:store_manage/core/constants/app_fonts.dart';
import 'package:store_manage/core/constants/app_numbers.dart';
import 'package:store_manage/core/constants/app_strings.dart';

class StockInSubmitButton extends StatelessWidget {
  final VoidCallback onPressed;

  const StockInSubmitButton({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Padding(
        padding: EdgeInsets.only(
          left: AppNumbers.DOUBLE_16,
          right: AppNumbers.DOUBLE_16,
          bottom: AppNumbers.DOUBLE_16 + MediaQuery.of(context).viewInsets.bottom,
        ),
        child: SizedBox(
          width: double.infinity,
          height: AppNumbers.DOUBLE_48,
          child: ElevatedButton(
            onPressed: onPressed,
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primary,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppNumbers.DOUBLE_12)),
            ),
            child: const Text(
              AppStrings.stockInSaveButton,
              style: TextStyle(
                fontSize: AppFontSizes.fontSize16,
                fontWeight: FontWeight.w700,
                fontFamily: AppFonts.inter,
                color: AppColors.textOnPrimary,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
