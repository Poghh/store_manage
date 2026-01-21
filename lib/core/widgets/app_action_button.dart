import 'package:flutter/material.dart';

import 'package:store_manage/core/constants/app_colors.dart';
import 'package:store_manage/core/constants/app_font_sizes.dart';
import 'package:store_manage/core/constants/app_fonts.dart';
import 'package:store_manage/core/constants/app_numbers.dart';

class AppActionButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final String label;
  final IconData? icon;
  final double height;
  final Color backgroundColor;
  final Color foregroundColor;
  final Color? borderColor;
  final double borderRadius;
  final double fontSize;
  final FontWeight fontWeight;

  const AppActionButton({
    super.key,
    required this.onPressed,
    required this.label,
    this.icon,
    this.height = AppNumbers.DOUBLE_48,
    this.backgroundColor = AppColors.primary,
    this.foregroundColor = AppColors.textOnPrimary,
    this.borderColor,
    this.borderRadius = AppNumbers.DOUBLE_12,
    this.fontSize = AppFontSizes.fontSize14,
    this.fontWeight = FontWeight.w700,
  });

  @override
  Widget build(BuildContext context) {
    final style = ElevatedButton.styleFrom(
      backgroundColor: backgroundColor,
      foregroundColor: foregroundColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(borderRadius),
        side: borderColor == null ? BorderSide.none : BorderSide(color: borderColor!),
      ),
    );

    final textWidget = Text(
      label,
      style: TextStyle(fontSize: fontSize, fontWeight: fontWeight, fontFamily: AppFonts.inter, color: foregroundColor),
    );

    return SizedBox(
      width: double.infinity,
      height: height,
      child: icon == null
          ? ElevatedButton(onPressed: onPressed, style: style, child: textWidget)
          : ElevatedButton.icon(
              onPressed: onPressed,
              style: style,
              icon: Icon(icon, color: foregroundColor),
              label: textWidget,
            ),
    );
  }
}
