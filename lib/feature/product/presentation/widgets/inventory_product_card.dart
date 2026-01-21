import 'package:flutter/material.dart';

import 'package:store_manage/core/constants/app_colors.dart';
import 'package:store_manage/core/constants/app_font_sizes.dart';
import 'package:store_manage/core/constants/app_fonts.dart';
import 'package:store_manage/core/constants/app_numbers.dart';
import 'package:store_manage/core/constants/app_strings.dart';
import 'package:store_manage/core/widgets/app_pill.dart';
import 'package:store_manage/core/widgets/app_product_thumbnail.dart';
import 'package:store_manage/core/widgets/app_surface_card.dart';
import 'package:store_manage/feature/product/data/models/product.dart';

class InventoryProductCard extends StatelessWidget {
  final Product product;
  final VoidCallback onTap;

  const InventoryProductCard({super.key, required this.product, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(AppNumbers.DOUBLE_16),
      onTap: onTap,
      child: AppSurfaceCard(
        padding: const EdgeInsets.all(AppNumbers.DOUBLE_12),
        borderRadius: AppNumbers.DOUBLE_16,
        boxShadow: const [BoxShadow(color: Color(0x14000000), blurRadius: 8, offset: Offset(0, 4))],
        child: Row(
          children: [
            AppProductThumbnail(
              imageUrl: product.image,
              size: AppNumbers.DOUBLE_56,
              borderRadius: AppNumbers.DOUBLE_12,
              padding: AppNumbers.DOUBLE_6,
              placeholderIcon: Icons.inventory_2_outlined,
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
                    product.productName,
                    style: const TextStyle(
                      fontSize: AppFontSizes.fontSize14,
                      fontWeight: FontWeight.w600,
                      fontFamily: AppFonts.inter,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  const SizedBox(height: AppNumbers.DOUBLE_4),
                  Text(
                    product.productCode,
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
                      AppPill(text: (product.quantity ?? 0).toString()),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
