import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import 'package:store_manage/core/constants/app_colors.dart';
import 'package:store_manage/core/constants/app_numbers.dart';
import 'package:store_manage/core/constants/app_strings.dart';
import 'package:store_manage/core/navigation/app_router.dart';
import 'package:store_manage/feature/product/data/models/product.dart';
import 'package:store_manage/feature/product/presentation/widgets/inventory_product_card.dart';
import 'package:store_manage/feature/product/presentation/widgets/inventory_search_bar.dart';

class InventoryBody extends StatelessWidget {
  final TextEditingController searchController;
  final ValueChanged<String> onSearchChanged;
  final bool isLoading;
  final List<Product> products;

  const InventoryBody({
    super.key,
    required this.searchController,
    required this.onSearchChanged,
    required this.isLoading,
    required this.products,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(
            AppNumbers.DOUBLE_16,
            AppNumbers.DOUBLE_8,
            AppNumbers.DOUBLE_16,
            AppNumbers.DOUBLE_12,
          ),
          child: InventorySearchBar(controller: searchController, onChanged: onSearchChanged),
        ),
        Expanded(
          child: isLoading
              ? const Center(child: CircularProgressIndicator(color: AppColors.primary))
              : ListView.separated(
                  padding: const EdgeInsets.fromLTRB(
                    AppNumbers.DOUBLE_16,
                    AppNumbers.DOUBLE_0,
                    AppNumbers.DOUBLE_16,
                    AppNumbers.DOUBLE_16,
                  ),
                  itemCount: products.length,
                  separatorBuilder: (context, index) => const SizedBox(height: AppNumbers.DOUBLE_12),
                  itemBuilder: (context, index) {
                    final product = products[index];
                    return InventoryProductCard(
                      product: product,
                      onTap: () {
                        context.router.push(
                          ProductDetailsRoute(
                            productCode: product.productCode,
                            productName: product.productName,
                            category: product.category ?? AppStrings.productDetailsSampleCategory,
                            platform: product.platform ?? AppStrings.productDetailsSamplePlatform,
                            brand: product.brand ?? AppStrings.productDetailsSampleBrand,
                            unit: product.unit ?? AppStrings.productDetailsSampleUnit,
                            quantity: (product.quantity ?? 0).toString(),
                            purchasePrice: AppStrings.productDetailsSamplePrice,
                            stockQuantityValue: product.quantity,
                            priceValue: product.purchasePrice,
                            stockInDate: product.stockInDate ?? AppStrings.productDetailsSampleDate,
                            imageUrl: product.image,
                          ),
                        );
                      },
                    );
                  },
                ),
        ),
      ],
    );
  }
}
