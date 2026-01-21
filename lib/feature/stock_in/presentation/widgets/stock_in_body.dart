import 'package:flutter/material.dart';

import 'package:store_manage/core/constants/app_colors.dart';
import 'package:store_manage/core/constants/app_numbers.dart';
import 'package:store_manage/feature/stock_in/presentation/widgets/stock_in_form.dart';
import 'package:store_manage/feature/stock_in/presentation/widgets/stock_in_form_controller.dart';
import 'package:store_manage/feature/stock_in/presentation/widgets/stock_in_search_bar.dart';

class StockInBody extends StatelessWidget {
  final TextEditingController searchController;
  final StockInFormController formController;

  const StockInBody({super.key, required this.searchController, required this.formController});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(
            AppNumbers.DOUBLE_16,
            AppNumbers.DOUBLE_16,
            AppNumbers.DOUBLE_16,
            AppNumbers.DOUBLE_8,
          ),
          child: StockInSearchBar(
            controller: searchController,
            onSelected: (item) {
              formController.productNameController.text = item.productName;
            },
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppNumbers.DOUBLE_16, vertical: AppNumbers.DOUBLE_8),
            child: Container(
              decoration: BoxDecoration(
                color: AppColors.surface,
                borderRadius: BorderRadius.circular(AppNumbers.DOUBLE_12),
                border: Border.all(color: AppColors.border),
              ),
              child: StockInForm(controller: formController),
            ),
          ),
        ),
      ],
    );
  }
}
