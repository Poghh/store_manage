import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';
import 'package:store_manage/core/constants/app_colors.dart';
import 'package:store_manage/core/constants/app_images.dart';
import 'package:store_manage/core/constants/app_numbers.dart';
import 'package:store_manage/core/constants/app_strings.dart';
import 'package:store_manage/core/navigation/app_router.dart';
import 'package:store_manage/feature/home/presentation/widgets/image_action_button.dart';

class QuickActionsSection extends StatelessWidget {
  const QuickActionsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppNumbers.DOUBLE_16),
      child: Column(
        children: [
          ImageActionButton(
            onTap: () => context.router.push(RetailRoute()),
            backgroundImage: AppImages.btnRetail,
            title: AppStrings.homeRetailTitle,
            subtitle: AppStrings.homeRetailSubtitle,
            leadingIcon: Icons.shopping_cart_outlined,
            leadingIconColor: AppColors.textOnPrimary,
            titleColor: AppColors.textOnPrimary,
            subtitleColor: AppColors.primaryLight,
            arrowBackgroundColor: AppColors.surface,
            arrowIconColor: AppColors.primaryDark,
          ),
          SizedBox(height: AppNumbers.DOUBLE_12),
          ImageActionButton(
            onTap: () => context.router.push(StockInRoute()),
            backgroundImage: AppImages.btnStockIn,
            title: AppStrings.homeStockInTitle,
            subtitle: AppStrings.homeStockInSubtitle,
            leadingIcon: Icons.inventory_2_outlined,
            leadingIconColor: AppColors.primaryDark,
            titleColor: AppColors.primaryDark,
            subtitleColor: AppColors.textSecondary,
            arrowBackgroundColor: AppColors.surface,
            arrowIconColor: AppColors.primaryDark,
          ),
          SizedBox(height: AppNumbers.DOUBLE_12),
          ImageActionButton(
            onTap: () => context.router.push(MoneyTransactionRoute()),
            backgroundImage: AppImages.btnRetail,
            title: AppStrings.homeMoneyTransactionTitle,
            subtitle: AppStrings.homeMoneyTransactionSubtitle,
            leadingIcon: Icons.currency_exchange,
            leadingIconColor: AppColors.textOnPrimary,
            titleColor: AppColors.textOnPrimary,
            subtitleColor: AppColors.primaryLight,
            arrowBackgroundColor: AppColors.surface,
            arrowIconColor: AppColors.primaryDark,
          ),
        ],
      ),
    );
  }
}
