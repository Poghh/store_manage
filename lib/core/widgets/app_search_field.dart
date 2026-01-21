import 'package:flutter/material.dart';

import 'package:store_manage/core/constants/app_colors.dart';
import 'package:store_manage/core/constants/app_font_sizes.dart';
import 'package:store_manage/core/constants/app_fonts.dart';
import 'package:store_manage/core/constants/app_numbers.dart';

class AppSearchField extends StatelessWidget {
  final TextEditingController controller;
  final FocusNode? focusNode;
  final String hintText;
  final ValueChanged<String>? onChanged;
  final Color iconColor;
  final IconData leadingIcon;
  final double leadingIconSize;
  final Widget? trailing;

  const AppSearchField({
    super.key,
    required this.controller,
    required this.hintText,
    this.focusNode,
    this.onChanged,
    this.iconColor = AppColors.textSecondary,
    this.leadingIcon = Icons.search,
    this.leadingIconSize = AppNumbers.DOUBLE_20,
    this.trailing,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: AppNumbers.DOUBLE_12, vertical: AppNumbers.DOUBLE_8),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(AppNumbers.DOUBLE_12),
        border: Border.all(color: AppColors.border),
      ),
      child: Row(
        children: [
          Icon(leadingIcon, size: leadingIconSize, color: iconColor),
          const SizedBox(width: AppNumbers.DOUBLE_8),
          Expanded(
            child: TextField(
              controller: controller,
              focusNode: focusNode,
              decoration: InputDecoration(hintText: hintText, border: InputBorder.none, isDense: true),
              style: const TextStyle(
                fontSize: AppFontSizes.fontSize14,
                fontWeight: FontWeight.w500,
                color: AppColors.textPrimary,
                fontFamily: AppFonts.inter,
              ),
              onChanged: onChanged,
            ),
          ),
          if (trailing != null) trailing!,
        ],
      ),
    );
  }
}
