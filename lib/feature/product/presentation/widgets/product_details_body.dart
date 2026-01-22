import 'package:flutter/material.dart';

import 'package:store_manage/core/constants/app_colors.dart';
import 'package:store_manage/core/constants/app_numbers.dart';
import 'package:store_manage/core/constants/app_strings.dart';
import 'package:store_manage/core/widgets/app_action_button.dart';
import 'package:store_manage/feature/product/presentation/widgets/product_header_card.dart';

class ProductDetailsBody extends StatelessWidget {
  final String displayName;
  final String displayCode;
  final String displayQuantity;
  final String? imageUrl;
  final List<Widget> infoRows;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  const ProductDetailsBody({
    super.key,
    required this.displayName,
    required this.displayCode,
    required this.displayQuantity,
    required this.imageUrl,
    required this.infoRows,
    required this.onEdit,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ProductHeaderCard(
          imageUrl: imageUrl,
          productName: displayName,
          productCode: displayCode,
          quantity: displayQuantity,
        ),
        const SizedBox(height: AppNumbers.DOUBLE_16),
        ...infoRows,
        const SizedBox(height: AppNumbers.DOUBLE_16),
        AppActionButton(
          onPressed: onEdit,
          label: AppStrings.productEditButton,
          backgroundColor: AppColors.primaryLight,
          foregroundColor: AppColors.primary,
          borderColor: AppColors.primary,
        ),
        const SizedBox(height: AppNumbers.DOUBLE_12),
        AppActionButton(
          onPressed: onDelete,
          label: AppStrings.productDeleteButton,
          backgroundColor: AppColors.error,
          foregroundColor: AppColors.textOnPrimary,
        ),
      ],
    );
  }
}
