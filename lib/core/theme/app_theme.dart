import 'package:flutter/material.dart';
import 'package:store_manage/core/constants/app_colors.dart';
import 'package:store_manage/core/constants/app_font_sizes.dart';
import 'package:store_manage/core/constants/app_fonts.dart';

class AppTheme {
  static final ThemeData defaultTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,
    fontFamily: AppFonts.inter,

    scaffoldBackgroundColor: AppColors.background,
    cardColor: AppColors.surface,
    dividerColor: AppColors.border,

    colorScheme: ColorScheme.fromSeed(
      seedColor: AppColors.primary,
      brightness: Brightness.light,
      primary: AppColors.primary,
      onPrimary: AppColors.textOnPrimary,
      surface: AppColors.surface,
      onSurface: AppColors.textPrimary,
    ),

    textTheme: appTextTheme,
  );

  static final TextTheme appTextTheme = TextTheme(
    // === DISPLAY (hero text, very large) ===
    displayLarge: TextStyle(
      fontSize: AppFontSizes.fontSize32,
      fontWeight: FontWeight.w700,
      height: 1.25,
      color: AppColors.textPrimary,
    ),
    displayMedium: TextStyle(
      fontSize: AppFontSizes.fontSize24,
      fontWeight: FontWeight.w700,
      color: AppColors.textPrimary,
    ),
    displaySmall: TextStyle(
      fontSize: AppFontSizes.fontSize22,
      fontWeight: FontWeight.w700,
      color: AppColors.textPrimary,
    ),

    // === HEADLINE (page/section titles) ===
    headlineLarge: TextStyle(
      fontSize: AppFontSizes.fontSize24,
      fontWeight: FontWeight.w600,
      color: AppColors.textPrimary,
    ),
    headlineMedium: TextStyle(
      fontSize: AppFontSizes.fontSize22,
      fontWeight: FontWeight.w600,
      color: AppColors.textPrimary,
    ),
    headlineSmall: TextStyle(
      fontSize: AppFontSizes.fontSize20,
      fontWeight: FontWeight.w600,
      color: AppColors.textPrimary,
    ),

    // === TITLE (card/section headers) ===
    titleLarge: TextStyle(
      fontSize: AppFontSizes.fontSize18,
      fontWeight: FontWeight.w600,
      color: AppColors.textPrimary,
    ),
    titleMedium: TextStyle(
      fontSize: AppFontSizes.fontSize16,
      fontWeight: FontWeight.w600,
      color: AppColors.textPrimary,
    ),
    titleSmall: TextStyle(
      fontSize: AppFontSizes.fontSize14,
      fontWeight: FontWeight.w600,
      color: AppColors.textPrimary,
    ),

    // === BODY (reading text) ===
    bodyLarge: TextStyle(
      fontSize: AppFontSizes.fontSize16,
      fontWeight: FontWeight.w400,
      color: AppColors.textPrimary,
    ),
    bodyMedium: TextStyle(
      fontSize: AppFontSizes.fontSize14,
      fontWeight: FontWeight.w400,
      color: AppColors.textSecondary,
    ),
    bodySmall: TextStyle(
      fontSize: AppFontSizes.fontSize12,
      fontWeight: FontWeight.w400,
      color: AppColors.textMuted,
    ),

    // === LABEL (buttons, chips, small text) ===
    labelLarge: TextStyle(
      fontSize: AppFontSizes.fontSize14,
      fontWeight: FontWeight.w500,
      color: AppColors.textPrimary,
    ),
    labelMedium: TextStyle(
      fontSize: AppFontSizes.fontSize12,
      fontWeight: FontWeight.w500,
      color: AppColors.textSecondary,
    ),
    labelSmall: TextStyle(
      fontSize: AppFontSizes.fontSize10,
      fontWeight: FontWeight.w500,
      color: AppColors.textMuted,
    ),
  );
}
