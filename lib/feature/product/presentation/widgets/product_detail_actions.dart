import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import 'package:store_manage/core/constants/app_numbers.dart';
import 'package:store_manage/core/constants/app_strings.dart';
import 'package:store_manage/core/navigation/app_router.dart';
import 'package:store_manage/core/widgets/app_action_button.dart';
import 'package:store_manage/core/constants/app_colors.dart';

class ProductDetailActions extends StatelessWidget {
  final String displayCode;
  final String displayName;
  final String displayQuantity;
  final String displayPrice;
  final int? priceValue;
  final String? imageUrl;
  final String? productCode;
  final String? productName;
  final String? category;
  final String? platform;
  final String? brand;
  final String? unit;
  final int? quantity;
  final int? purchasePrice;
  final String? stockInDate;

  const ProductDetailActions({
    super.key,
    required this.displayCode,
    required this.displayName,
    required this.displayQuantity,
    required this.displayPrice,
    required this.priceValue,
    required this.imageUrl,
    this.productCode,
    this.productName,
    this.category,
    this.platform,
    this.brand,
    this.unit,
    this.quantity,
    this.purchasePrice,
    this.stockInDate,
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
                child: AppActionButton(
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
                  label: AppStrings.productDetailsSellButton,
                  icon: Icons.local_mall_outlined,
                ),
              ),
            ),
            const SizedBox(width: AppNumbers.DOUBLE_12),
            Expanded(
              child: SizedBox(
                height: AppNumbers.DOUBLE_48,
                child: AppActionButton(
                  onPressed: () => context.router.push(
                    StockInRoute(
                      productCode: productCode,
                      productName: productName,
                      category: category,
                      platform: platform,
                      brand: brand,
                      unit: unit,
                      quantity: quantity,
                      purchasePrice: purchasePrice,
                      stockInDate: stockInDate,
                    ),
                  ),
                  label: AppStrings.productDetailsStockInButton,
                  icon: Icons.inventory_2_outlined,
                  backgroundColor: AppColors.primaryLight,
                  foregroundColor: AppColors.primary,
                  borderColor: AppColors.primary,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
