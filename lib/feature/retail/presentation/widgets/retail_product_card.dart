import 'package:flutter/material.dart';

import 'package:store_manage/core/constants/app_colors.dart';
import 'package:store_manage/core/constants/app_font_sizes.dart';
import 'package:store_manage/core/constants/app_fonts.dart';
import 'package:store_manage/core/constants/app_numbers.dart';
import 'package:store_manage/core/constants/app_strings.dart';
import 'package:store_manage/core/widgets/app_field_container.dart';
import 'package:store_manage/core/widgets/app_pill.dart';
import 'package:store_manage/core/widgets/app_product_thumbnail.dart';

class RetailProductCard extends StatelessWidget {
  final String name;
  final String code;
  final int stock;
  final String? imageUrl;

  const RetailProductCard({super.key, required this.name, required this.code, required this.stock, this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return AppFieldContainer(
      padding: const EdgeInsets.all(AppNumbers.DOUBLE_12),
      borderRadius: AppNumbers.DOUBLE_16,
      child: Row(
        children: [
          AppProductThumbnail(
            imageUrl: imageUrl,
            size: AppNumbers.DOUBLE_56,
            borderRadius: AppNumbers.DOUBLE_12,
            padding: AppNumbers.DOUBLE_6,
            placeholderIcon: Icons.phone_iphone,
            placeholderColor: AppColors.primary,
            placeholderSize: AppNumbers.DOUBLE_28,
            backgroundColor: AppColors.background,
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
          AppPill(text: '${AppStrings.productDetailsStockLabel} $stock', fontWeight: FontWeight.w600),
        ],
      ),
    );
  }
}
