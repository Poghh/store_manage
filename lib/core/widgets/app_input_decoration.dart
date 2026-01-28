import 'package:flutter/material.dart';

import 'package:store_manage/core/constants/app_colors.dart';
import 'package:store_manage/core/constants/app_font_sizes.dart';
import 'package:store_manage/core/constants/app_fonts.dart';
import 'package:store_manage/core/constants/app_numbers.dart';

class AppInputDecoration {
  static InputDecoration build({
    String? hintText,
    String? labelText,
    Widget? suffixIcon,
    Widget? prefixIcon,
    EdgeInsetsGeometry? contentPadding,
    Color? fillColor,
    bool obscureText = false,
    String? counterText,
  }) {
    return InputDecoration(
      hintText: hintText,
      labelText: labelText,
      counterText: counterText,
      hintStyle: const TextStyle(
        fontSize: AppFontSizes.fontSize14,
        fontWeight: FontWeight.w500,
        fontFamily: AppFonts.inter,
        color: AppColors.textMuted,
      ),
      labelStyle: const TextStyle(
        fontSize: AppFontSizes.fontSize14,
        fontWeight: FontWeight.w500,
        fontFamily: AppFonts.inter,
        color: AppColors.textSecondary,
      ),
      floatingLabelStyle: const TextStyle(
        fontSize: AppFontSizes.fontSize14,
        fontWeight: FontWeight.w500,
        fontFamily: AppFonts.inter,
        color: AppColors.primary,
      ),
      filled: true,
      fillColor: fillColor ?? AppColors.surface,
      contentPadding:
          contentPadding ??
          const EdgeInsets.symmetric(horizontal: AppNumbers.DOUBLE_12, vertical: AppNumbers.DOUBLE_12),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppNumbers.DOUBLE_12),
        borderSide: const BorderSide(color: AppColors.border),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppNumbers.DOUBLE_12),
        borderSide: const BorderSide(color: AppColors.border),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppNumbers.DOUBLE_12),
        borderSide: const BorderSide(color: AppColors.primary),
      ),
      suffixIcon: suffixIcon,
      prefixIcon: prefixIcon,
    );
  }
}
