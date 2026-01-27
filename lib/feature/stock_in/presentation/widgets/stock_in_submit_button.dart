import 'package:flutter/material.dart';

import 'package:store_manage/core/constants/app_colors.dart';
import 'package:store_manage/core/constants/app_font_sizes.dart';
import 'package:store_manage/core/constants/app_numbers.dart';
import 'package:store_manage/core/constants/app_strings.dart';
import 'package:store_manage/core/widgets/app_action_button.dart';

class StockInSubmitButton extends StatelessWidget {
  final VoidCallback? onPressed;

  const StockInSubmitButton({super.key, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.background,
      child: SafeArea(
        top: false,
        child: Padding(
          padding: EdgeInsets.only(
            left: AppNumbers.DOUBLE_16,
            right: AppNumbers.DOUBLE_16,
            bottom: AppNumbers.DOUBLE_16 + MediaQuery.of(context).viewInsets.bottom,
          ),
          child: AppActionButton(
            onPressed: onPressed,
            label: AppStrings.stockInSaveButton,
            fontSize: AppFontSizes.fontSize16,
          ),
        ),
      ),
    );
  }
}
