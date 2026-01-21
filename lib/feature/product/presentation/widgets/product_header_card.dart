import 'package:flutter/material.dart';

import 'package:store_manage/core/constants/app_colors.dart';
import 'package:store_manage/core/constants/app_font_sizes.dart';
import 'package:store_manage/core/constants/app_fonts.dart';
import 'package:store_manage/core/constants/app_numbers.dart';
import 'package:store_manage/core/constants/app_strings.dart';
import 'package:store_manage/core/widgets/app_pill.dart';
import 'package:store_manage/core/widgets/app_product_thumbnail.dart';
import 'package:store_manage/core/widgets/app_surface_card.dart';

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
    return AppSurfaceCard(
      padding: const EdgeInsets.all(AppNumbers.DOUBLE_12),
      borderRadius: AppNumbers.DOUBLE_16,
      boxShadow: const [BoxShadow(color: Color(0x14000000), blurRadius: 8, offset: Offset(0, 4))],
      child: Row(
        children: [
          AppProductThumbnail(
            imageUrl: imageUrl,
            size: AppNumbers.DOUBLE_64,
            borderRadius: AppNumbers.DOUBLE_12,
            padding: AppNumbers.DOUBLE_8,
            placeholderIcon: Icons.phone_iphone,
            placeholderColor: AppColors.primary,
            placeholderSize: AppNumbers.DOUBLE_32,
            backgroundColor: AppColors.background,
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
                    AppPill(text: quantity),
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
