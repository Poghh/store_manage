import 'package:flutter/material.dart';

import 'package:store_manage/core/constants/app_colors.dart';
import 'package:store_manage/core/constants/app_font_sizes.dart';
import 'package:store_manage/core/constants/app_fonts.dart';
import 'package:store_manage/core/constants/app_numbers.dart';
import 'package:store_manage/core/constants/app_strings.dart';

class InventorySearchBar extends StatelessWidget {
  final TextEditingController controller;
  final ValueChanged<String> onChanged;

  const InventorySearchBar({super.key, required this.controller, required this.onChanged});

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
          const Icon(Icons.search, size: AppNumbers.DOUBLE_20, color: AppColors.textMuted),
          const SizedBox(width: AppNumbers.DOUBLE_8),
          Expanded(
            child: TextField(
              controller: controller,
              decoration: const InputDecoration(
                hintText: AppStrings.homeProductSearchPlaceholder,
                border: InputBorder.none,
                isDense: true,
              ),
              style: const TextStyle(
                fontSize: AppFontSizes.fontSize14,
                fontWeight: FontWeight.w500,
                fontFamily: AppFonts.inter,
                color: AppColors.textPrimary,
              ),
              onChanged: onChanged,
            ),
          ),
          const Icon(Icons.qr_code_scanner, size: AppNumbers.DOUBLE_20, color: AppColors.textSecondary),
        ],
      ),
    );
  }
}
