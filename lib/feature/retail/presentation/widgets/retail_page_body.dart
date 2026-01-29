import 'package:flutter/material.dart';

import 'package:store_manage/core/constants/app_colors.dart';
import 'package:store_manage/core/constants/app_numbers.dart';
import 'package:store_manage/core/constants/app_strings.dart';
import 'package:store_manage/feature/retail/presentation/widgets/product_search_bar.dart';
import 'package:store_manage/feature/product/data/models/product.dart';
import 'package:store_manage/feature/retail/presentation/widgets/payment_method.dart';
import 'package:store_manage/feature/retail/presentation/widgets/retail_content.dart';

class RetailPageBody extends StatelessWidget {
  final bool hasProduct;
  final String displayName;
  final String displayCode;
  final int displayStock;
  final String? displayImage;
  final int quantity;
  final VoidCallback onDecrease;
  final VoidCallback onIncrease;
  final TextEditingController priceController;
  final ValueChanged<String> onPriceChanged;
  final int purchasePrice;
  final int total;
  final PaymentMethod paymentMethod;
  final String paymentMethodLabel;
  final ValueChanged<PaymentMethod> onPaymentChanged;
  final VoidCallback onConfirm;
  final ValueChanged<Product> onProductSelected;

  const RetailPageBody({
    super.key,
    required this.hasProduct,
    required this.displayName,
    required this.displayCode,
    required this.displayStock,
    required this.displayImage,
    required this.quantity,
    required this.onDecrease,
    required this.onIncrease,
    required this.priceController,
    required this.onPriceChanged,
    required this.purchasePrice,
    required this.total,
    required this.paymentMethod,
    required this.paymentMethodLabel,
    required this.onPaymentChanged,
    required this.onConfirm,
    required this.onProductSelected,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(AppNumbers.DOUBLE_16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ProductSearchBar(
            hintText: AppStrings.retailSearchPlaceholder,
            iconColor: AppColors.textMuted,
            onSelected: onProductSelected,
          ),
          const SizedBox(height: AppNumbers.DOUBLE_12),
          if (hasProduct)
            RetailContent(
              displayName: displayName,
              displayCode: displayCode,
              displayStock: displayStock,
              displayImage: displayImage,
              quantity: quantity,
              onDecrease: onDecrease,
              onIncrease: onIncrease,
              priceController: priceController,
              onPriceChanged: onPriceChanged,
              purchasePrice: purchasePrice,
              total: total,
              paymentMethod: paymentMethod,
              paymentMethodLabel: paymentMethodLabel,
              onPaymentChanged: onPaymentChanged,
              onConfirm: onConfirm,
            ),
        ],
      ),
    );
  }
}
