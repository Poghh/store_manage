import 'package:flutter/material.dart';

import 'package:store_manage/core/constants/app_colors.dart';
import 'package:store_manage/core/constants/app_font_sizes.dart';
import 'package:store_manage/core/constants/app_fonts.dart';
import 'package:store_manage/core/constants/app_numbers.dart';
import 'package:store_manage/core/constants/app_strings.dart';

class ProductHeaderCard extends StatelessWidget {
  final String? imageUrl;
  final String productName;
  final String productCode;
  final String quantity;

  const ProductHeaderCard({
    super.key,
    required this.imageUrl,
    required this.productName,
    required this.productCode,
    required this.quantity,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppNumbers.DOUBLE_12),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(AppNumbers.DOUBLE_16),
        border: Border.all(color: AppColors.border),
        boxShadow: const [BoxShadow(color: Color(0x14000000), blurRadius: 8, offset: Offset(0, 4))],
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(AppNumbers.DOUBLE_12),
            child: Container(
              width: AppNumbers.DOUBLE_64,
              height: AppNumbers.DOUBLE_64,
              color: AppColors.background,
              padding: const EdgeInsets.all(AppNumbers.DOUBLE_8),
              child: imageUrl == null || imageUrl!.isEmpty
                  ? const Icon(Icons.phone_iphone, color: AppColors.primary, size: AppNumbers.DOUBLE_32)
                  : Image.network(imageUrl!, fit: BoxFit.contain),
            ),
          ),
          const SizedBox(width: AppNumbers.DOUBLE_12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  productName,
                  style: const TextStyle(
                    fontSize: AppFontSizes.fontSize16,
                    fontWeight: FontWeight.w600,
                    fontFamily: AppFonts.inter,
                    color: AppColors.textPrimary,
                  ),
                ),
                const SizedBox(height: AppNumbers.DOUBLE_4),
                Text(
                  productCode,
                  style: const TextStyle(
                    fontSize: AppFontSizes.fontSize12,
                    fontWeight: FontWeight.w500,
                    fontFamily: AppFonts.inter,
                    color: AppColors.textMuted,
                  ),
                ),
                const SizedBox(height: AppNumbers.DOUBLE_8),
                Row(
                  children: [
                    const Text(
                      AppStrings.productDetailsStockLabel,
                      style: TextStyle(
                        fontSize: AppFontSizes.fontSize12,
                        fontWeight: FontWeight.w500,
                        fontFamily: AppFonts.inter,
                        color: AppColors.textSecondary,
                      ),
                    ),
                    const SizedBox(width: AppNumbers.DOUBLE_6),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: AppNumbers.DOUBLE_8,
                        vertical: AppNumbers.DOUBLE_2,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.primaryLight,
                        borderRadius: BorderRadius.circular(AppNumbers.DOUBLE_8),
                      ),
                      child: Text(
                        quantity,
                        style: const TextStyle(
                          fontSize: AppFontSizes.fontSize12,
                          fontWeight: FontWeight.w700,
                          fontFamily: AppFonts.inter,
                          color: AppColors.primary,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
