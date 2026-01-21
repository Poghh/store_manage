import 'package:flutter/material.dart';

import 'package:store_manage/core/constants/app_numbers.dart';
import 'package:store_manage/feature/transactions/presentation/widgets/transaction_item_card.dart';

class TransactionsList extends StatelessWidget {
  final List<({String productCode, String productName, int quantity, int price, int total, String paymentMethod})>
  items;

  const TransactionsList({super.key, required this.items});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: const EdgeInsets.fromLTRB(
        AppNumbers.DOUBLE_12,
        AppNumbers.DOUBLE_8,
        AppNumbers.DOUBLE_12,
        AppNumbers.DOUBLE_12,
      ),
      itemCount: items.length,
      separatorBuilder: (_, __) => const SizedBox(height: AppNumbers.DOUBLE_12),
      itemBuilder: (context, index) {
        final item = items[index];
        return TransactionItemCard(
          productCode: item.productCode,
          productName: item.productName,
          quantity: item.quantity,
          price: item.price,
          total: item.total,
          paymentMethod: item.paymentMethod,
        );
      },
    );
  }
}
