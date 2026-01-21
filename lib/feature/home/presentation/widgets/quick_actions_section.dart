import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:store_manage/core/DI/di.dart';
import 'package:store_manage/core/constants/app_colors.dart';
import 'package:store_manage/core/constants/app_numbers.dart';
import 'package:store_manage/core/constants/app_strings.dart';
import 'package:store_manage/core/navigation/app_router.dart';
import 'package:store_manage/core/utils/common_funtion_utils.dart';
import 'package:store_manage/feature/home/presentation/widgets/image_action_button.dart';
import 'package:store_manage/feature/home/presentation/widgets/product_search_bar.dart';
import 'package:store_manage/feature/product/data/repositories/product_repository.dart';
import 'package:store_manage/feature/product/presentation/cubit/product_search_cubit.dart';

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
            backgroundImage: 'assets/images/btn_retail.png',
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
            backgroundImage: 'assets/images/btn_stock_in.png',
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
          BlocProvider<ProductSearchCubit>(
            create: (_) => ProductSearchCubit(di<ProductRepository>())..prime(),
            child: ProductSearchBar(
              onSelected: (product) {
                context.router.push(
                  ProductDetailsRoute(
                    productCode: product.productCode,
                    productName: product.productName,
                    category: product.category ?? AppStrings.productDetailsSampleCategory,
                    platform: product.platform ?? AppStrings.productDetailsSamplePlatform,
                    brand: product.brand ?? AppStrings.productDetailsSampleBrand,
                    unit: product.unit ?? AppStrings.productDetailsSampleUnit,
                    quantity: (product.quantity ?? 0).toString(),
                    purchasePrice: product.purchasePrice == null
                        ? AppStrings.productDetailsSamplePrice
                        : CommonFuntionUtils.formatCurrency(product.purchasePrice!),
                    stockQuantityValue: product.quantity,
                    priceValue: product.purchasePrice,
                    stockInDate: product.stockInDate ?? AppStrings.productDetailsSampleDate,
                    imageUrl: product.image,
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
