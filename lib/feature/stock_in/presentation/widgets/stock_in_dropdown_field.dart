import 'package:flutter/material.dart';

import 'package:store_manage/core/constants/app_colors.dart';
import 'package:store_manage/core/constants/app_font_sizes.dart';
import 'package:store_manage/core/constants/app_fonts.dart';
import 'package:store_manage/core/constants/app_numbers.dart';

class StockInDropdownField extends StatelessWidget {
  final List<String> items;
  final String? value;
  final String? Function(String?)? validator;
  final ValueChanged<String?>? onChanged;

  const StockInDropdownField({super.key, required this.items, required this.value, this.validator, this.onChanged});

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      initialValue: value,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      icon: const Icon(Icons.expand_more, color: AppColors.textSecondary),
      validator: validator,
      decoration: InputDecoration(
        filled: true,
        fillColor: AppColors.surface,
        contentPadding: const EdgeInsets.symmetric(horizontal: AppNumbers.DOUBLE_12, vertical: AppNumbers.DOUBLE_12),
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
      ),
      items: items
          .map(
            (item) => DropdownMenuItem<String>(
              value: item,
              child: Text(
                item,
                style: const TextStyle(
                  fontSize: AppFontSizes.fontSize14,
                  fontWeight: FontWeight.w500,
                  fontFamily: AppFonts.inter,
                  color: AppColors.textPrimary,
                ),
              ),
            ),
          )
          .toList(),
      onChanged: onChanged,
    );
  }
}
