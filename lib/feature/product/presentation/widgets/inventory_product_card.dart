import 'package:flutter/material.dart';

import 'package:store_manage/core/constants/app_colors.dart';
import 'package:store_manage/core/constants/app_font_sizes.dart';
import 'package:store_manage/core/constants/app_fonts.dart';
import 'package:store_manage/core/constants/app_numbers.dart';
import 'package:store_manage/core/constants/app_strings.dart';
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
      child: Container(
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
                width: AppNumbers.DOUBLE_56,
                height: AppNumbers.DOUBLE_56,
                color: AppColors.background,
                padding: const EdgeInsets.all(AppNumbers.DOUBLE_6),
                child: product.image == null || product.image!.isEmpty
                    ? const Icon(Icons.inventory_2_outlined, color: AppColors.primary, size: AppNumbers.DOUBLE_28)
                    : Image.network(product.image!, fit: BoxFit.contain),
              ),
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
                          (product.quantity ?? 0).toString(),
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
      ),
    );
  }
}
