import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import 'package:store_manage/core/constants/app_colors.dart';
import 'package:store_manage/core/constants/app_font_sizes.dart';
import 'package:store_manage/core/constants/app_fonts.dart';
import 'package:store_manage/core/constants/app_numbers.dart';
import 'package:store_manage/core/constants/app_strings.dart';
import 'package:store_manage/core/navigation/app_router.dart';

class ProductDetailActions extends StatelessWidget {
  final String displayCode;
  final String displayName;
  final String displayQuantity;
  final String displayPrice;
  final int? priceValue;
  final String? imageUrl;

  const ProductDetailActions({
    super.key,
    required this.displayCode,
    required this.displayName,
    required this.displayQuantity,
    required this.displayPrice,
    required this.priceValue,
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(
          AppNumbers.DOUBLE_16,
          AppNumbers.DOUBLE_8,
          AppNumbers.DOUBLE_16,
          AppNumbers.DOUBLE_16,
        ),
        child: Row(
          children: [
            Expanded(
              child: SizedBox(
                height: AppNumbers.DOUBLE_48,
                child: ElevatedButton.icon(
                  onPressed: () {
                    final parsedQuantity = int.tryParse(displayQuantity.replaceAll(RegExp(r'[^0-9]'), '')) ?? 0;
                    final parsedPurchasePrice =
                        int.tryParse(displayPrice.replaceAll(RegExp(r'[^0-9]'), '')) ?? (priceValue ?? 0);
                    context.router.push(
                      RetailRoute(
                        productCode: displayCode,
                        productName: displayName,
                        stockQuantity: parsedQuantity,
                        price: parsedPurchasePrice,
                        imageUrl: imageUrl,
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppNumbers.DOUBLE_12)),
                  ),
                  icon: const Icon(Icons.local_mall_outlined, color: AppColors.textOnPrimary),
                  label: const Text(
                    AppStrings.productDetailsSellButton,
                    style: TextStyle(
                      fontSize: AppFontSizes.fontSize14,
                      fontWeight: FontWeight.w700,
                      fontFamily: AppFonts.inter,
                      color: AppColors.textOnPrimary,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(width: AppNumbers.DOUBLE_12),
            Expanded(
              child: SizedBox(
                height: AppNumbers.DOUBLE_48,
                child: ElevatedButton.icon(
                  onPressed: () => context.router.push(const StockInRoute()),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primaryLight,
                    foregroundColor: AppColors.primary,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(AppNumbers.DOUBLE_12),
                      side: const BorderSide(color: AppColors.primary),
                    ),
                  ),
                  icon: const Icon(Icons.inventory_2_outlined, color: AppColors.primary),
                  label: const Text(
                    AppStrings.productDetailsStockInButton,
                    style: TextStyle(
                      fontSize: AppFontSizes.fontSize14,
                      fontWeight: FontWeight.w700,
                      fontFamily: AppFonts.inter,
                      color: AppColors.primary,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
