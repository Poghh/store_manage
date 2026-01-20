import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import 'package:store_manage/core/constants/app_colors.dart';
import 'package:store_manage/core/constants/app_font_sizes.dart';
import 'package:store_manage/core/constants/app_fonts.dart';
import 'package:store_manage/core/constants/app_numbers.dart';
import 'package:store_manage/core/constants/app_strings.dart';
import 'package:store_manage/core/utils/common_funtion_utils.dart';
import 'package:store_manage/feature/product/presentation/widgets/info_row.dart';
import 'package:store_manage/feature/product/presentation/widgets/product_detail_actions.dart';
import 'package:store_manage/feature/product/presentation/widgets/product_header_card.dart';

@RoutePage()
class ProductDetailsPage extends StatelessWidget {
  final String productCode;
  final String productName;
  final String category;
  final String platform;
  final String brand;
  final String unit;
  final String quantity;
  final String purchasePrice;
  final String stockInDate;
  final String? imageUrl;
  final int? stockQuantityValue;
  final int? priceValue;

  const ProductDetailsPage({
    super.key,
    this.productCode = '',
    this.productName = '',
    this.category = '',
    this.platform = '',
    this.brand = '',
    this.unit = '',
    this.quantity = '',
    this.purchasePrice = '',
    this.stockInDate = '',
    this.imageUrl,
    this.stockQuantityValue,
    this.priceValue,
  });

  @override
  Widget build(BuildContext context) {
    final displayCode = productCode.isEmpty ? AppStrings.productDetailsSampleCode : productCode;
    final displayName = productName.isEmpty ? AppStrings.productDetailsSampleName : productName;
    final displayCategory = category.isEmpty ? AppStrings.productDetailsSampleCategory : category;
    final displayPlatform = platform.isEmpty ? AppStrings.productDetailsSamplePlatform : platform;
    final displayBrand = brand.isEmpty ? AppStrings.productDetailsSampleBrand : brand;
    final displayUnit = unit.isEmpty ? AppStrings.productDetailsSampleUnit : unit;
    final displayQuantity = quantity.isNotEmpty
        ? quantity
        : (stockQuantityValue?.toString() ?? AppStrings.productDetailsSampleQuantity);
    final displayPrice = purchasePrice.isNotEmpty
        ? purchasePrice
        : (priceValue == null ? AppStrings.productDetailsSamplePrice : CommonFuntionUtils.formatCurrency(priceValue!));
    final displayDate = stockInDate.isEmpty ? AppStrings.productDetailsSampleDate : stockInDate;
    final infoItems = [
      _InfoItem(AppStrings.stockInProductCodeLabel, displayCode),
      _InfoItem(AppStrings.stockInProductNameLabel, displayName),
      _InfoItem(AppStrings.stockInCategoryLabel, displayCategory),
      _InfoItem(AppStrings.stockInPlatformLabel, displayPlatform),
      _InfoItem(AppStrings.stockInBrandLabel, displayBrand),
      _InfoItem(AppStrings.stockInUnitLabel, displayUnit),
      _InfoItem(AppStrings.stockInQuantityLabel, displayQuantity),
      _InfoItem(AppStrings.stockInPurchasePriceLabel, displayPrice),
      _InfoItem(AppStrings.stockInDateLabel, displayDate),
    ];

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: AppNumbers.DOUBLE_0,
        scrolledUnderElevation: AppNumbers.DOUBLE_0,
        surfaceTintColor: AppColors.background,
        leading: IconButton(
          onPressed: () => context.maybePop(),
          icon: const Icon(Icons.arrow_back, color: AppColors.textPrimary),
        ),
        title: const Text(
          AppStrings.productDetailsTitle,
          style: TextStyle(
            fontSize: AppFontSizes.fontSize18,
            fontWeight: FontWeight.w600,
            fontFamily: AppFonts.inter,
            color: AppColors.textPrimary,
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(AppNumbers.DOUBLE_16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ProductHeaderCard(
                imageUrl: imageUrl,
                productName: displayName,
                productCode: displayCode,
                quantity: displayQuantity,
              ),
              const SizedBox(height: AppNumbers.DOUBLE_16),
              ...infoItems.map((item) => InfoRow(label: item.label, value: item.value)),
            ],
          ),
        ),
      ),
      bottomNavigationBar: ProductDetailActions(
        displayCode: displayCode,
        displayName: displayName,
        displayQuantity: displayQuantity,
        displayPrice: displayPrice,
        priceValue: priceValue,
        imageUrl: imageUrl,
      ),
    );
  }
}

class _InfoItem {
  final String label;
  final String value;

  const _InfoItem(this.label, this.value);
}
