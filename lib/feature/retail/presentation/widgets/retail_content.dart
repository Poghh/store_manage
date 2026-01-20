import 'package:flutter/material.dart';

import 'package:store_manage/core/constants/app_numbers.dart';
import 'package:store_manage/core/constants/app_strings.dart';
import 'package:store_manage/feature/retail/presentation/widgets/confirm_button.dart';
import 'package:store_manage/feature/retail/presentation/widgets/payment_method.dart';
import 'package:store_manage/feature/retail/presentation/widgets/payment_row.dart';
import 'package:store_manage/feature/retail/presentation/widgets/price_fields.dart';
import 'package:store_manage/feature/retail/presentation/widgets/quantity_selector.dart';
import 'package:store_manage/feature/retail/presentation/widgets/retail_product_card.dart';
import 'package:store_manage/feature/retail/presentation/widgets/retail_section_label.dart';
import 'package:store_manage/feature/retail/presentation/widgets/total_row.dart';

class RetailContent extends StatelessWidget {
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
  final VoidCallback? onConfirm;

  const RetailContent({
    super.key,
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
    this.onConfirm,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RetailProductCard(name: displayName, code: displayCode, stock: displayStock, imageUrl: displayImage),
        const SizedBox(height: AppNumbers.DOUBLE_16),
        const RetailSectionLabel(text: AppStrings.retailQuantityLabel),
        const SizedBox(height: AppNumbers.DOUBLE_8),
        QuantitySelector(quantity: quantity, onDecrease: onDecrease, onIncrease: onIncrease),
        const SizedBox(height: AppNumbers.DOUBLE_16),
        const RetailSectionLabel(text: AppStrings.retailPriceLabel),
        const SizedBox(height: AppNumbers.DOUBLE_8),
        PriceField(controller: priceController, onChanged: onPriceChanged),
        const SizedBox(height: AppNumbers.DOUBLE_12),
        const RetailSectionLabel(text: AppStrings.stockInPurchasePriceLabel),
        const SizedBox(height: AppNumbers.DOUBLE_8),
        DisabledPriceField(value: purchasePrice),
        const SizedBox(height: AppNumbers.DOUBLE_16),
        PaymentRow(total: total, methodLabel: paymentMethodLabel, value: paymentMethod, onChanged: onPaymentChanged),
        const SizedBox(height: AppNumbers.DOUBLE_8),
        TotalRow(total: total),
        const SizedBox(height: AppNumbers.DOUBLE_16),
        ConfirmButton(onPressed: onConfirm),
      ],
    );
  }
}
