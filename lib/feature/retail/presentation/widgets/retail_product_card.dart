import 'package:flutter/material.dart';

import 'package:store_manage/core/constants/app_colors.dart';
import 'package:store_manage/core/constants/app_font_sizes.dart';
import 'package:store_manage/core/constants/app_fonts.dart';
import 'package:store_manage/core/constants/app_numbers.dart';

class RetailProductCard extends StatelessWidget {
  final String name;
  final String code;
  final int stock;
  final String? imageUrl;

  const RetailProductCard({super.key, required this.name, required this.code, required this.stock, this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppNumbers.DOUBLE_12),
      decoration: BoxDecoration(color: AppColors.surface, borderRadius: BorderRadius.circular(AppNumbers.DOUBLE_16)),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(AppNumbers.DOUBLE_12),
            child: Container(
              width: AppNumbers.DOUBLE_56,
              height: AppNumbers.DOUBLE_56,
              color: AppColors.background,
              padding: const EdgeInsets.all(AppNumbers.DOUBLE_6),
              child: imageUrl == null || imageUrl!.isEmpty
                  ? const Icon(Icons.phone_iphone, color: AppColors.primary, size: AppNumbers.DOUBLE_28)
                  : Image.network(imageUrl!, fit: BoxFit.contain),
            ),
          ),
          const SizedBox(width: AppNumbers.DOUBLE_12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: const TextStyle(
                    fontSize: AppFontSizes.fontSize14,
                    fontWeight: FontWeight.w600,
                    fontFamily: AppFonts.inter,
                    color: AppColors.textPrimary,
                  ),
                ),
                const SizedBox(height: AppNumbers.DOUBLE_4),
                Text(
                  code,
                  style: const TextStyle(
                    fontSize: AppFontSizes.fontSize12,
                    fontWeight: FontWeight.w500,
                    fontFamily: AppFonts.inter,
                    color: AppColors.textMuted,
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: AppNumbers.DOUBLE_8, vertical: AppNumbers.DOUBLE_2),
            decoration: BoxDecoration(
              color: AppColors.primaryLight,
              borderRadius: BorderRadius.circular(AppNumbers.DOUBLE_8),
            ),
            child: Text(
              'Tồn $stock',
              style: const TextStyle(
                fontSize: AppFontSizes.fontSize12,
                fontWeight: FontWeight.w600,
                fontFamily: AppFonts.inter,
                color: AppColors.primary,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
