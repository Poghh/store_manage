import 'package:flutter/material.dart';

import 'package:store_manage/core/constants/app_colors.dart';
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
    final textTheme = Theme.of(context).textTheme;

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
                  Text(product.productName, style: textTheme.titleSmall),
                  const SizedBox(height: AppNumbers.DOUBLE_4),
                  Text(product.productCode, style: textTheme.labelMedium?.copyWith(color: AppColors.textMuted)),
                  const SizedBox(height: AppNumbers.DOUBLE_8),
                  Row(
                    children: [
                      Text(AppStrings.productDetailsStockLabel, style: textTheme.labelMedium),
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
