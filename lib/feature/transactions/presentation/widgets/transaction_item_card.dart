import 'package:flutter/material.dart';

import 'package:store_manage/core/constants/app_colors.dart';
import 'package:store_manage/core/constants/app_numbers.dart';
import 'package:store_manage/core/constants/app_strings.dart';
import 'package:store_manage/core/widgets/app_surface_card.dart';
import 'package:store_manage/core/utils/common_funtion_utils.dart';
import 'package:store_manage/feature/transactions/presentation/widgets/transaction_info_block.dart';

class TransactionItemCard extends StatelessWidget {
  final String productCode;
  final String productName;
  final int quantity;
  final int price;
  final int total;
  final String paymentMethod;

  const TransactionItemCard({
    super.key,
    required this.productCode,
    required this.productName,
    required this.quantity,
    required this.price,
    required this.total,
    required this.paymentMethod,
  });

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return AppSurfaceCard(
      backgroundColor: AppColors.background,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  productName,
                  style: textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w700),
                  maxLines: AppNumbers.INT_2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              const SizedBox(width: AppNumbers.DOUBLE_8),
              Text(productCode, style: textTheme.labelMedium?.copyWith(fontWeight: FontWeight.w600)),
            ],
          ),
          const SizedBox(height: AppNumbers.DOUBLE_8),
          Row(
            children: [
              TransactionInfoBlock(label: AppStrings.transactionsItemQuantitySoldLabel, value: quantity.toString()),
              const SizedBox(width: AppNumbers.DOUBLE_12),
              TransactionInfoBlock(
                label: AppStrings.transactionsItemPriceLabel,
                value: CommonFuntionUtils.formatCurrency(price),
              ),
              const SizedBox(width: AppNumbers.DOUBLE_12),
              TransactionInfoBlock(
                label: AppStrings.transactionsItemTotalLabel,
                value: CommonFuntionUtils.formatCurrency(total),
              ),
            ],
          ),
          const SizedBox(height: AppNumbers.DOUBLE_8),
          Row(
            children: [
              const Icon(Icons.payments_outlined, size: AppNumbers.DOUBLE_16),
              const SizedBox(width: AppNumbers.DOUBLE_6),
              Text(paymentMethod, style: textTheme.labelMedium?.copyWith(fontWeight: FontWeight.w600)),
            ],
          ),
        ],
      ),
    );
  }
}
