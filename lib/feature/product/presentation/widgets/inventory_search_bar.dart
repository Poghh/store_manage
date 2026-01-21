import 'package:flutter/material.dart';

import 'package:store_manage/core/constants/app_colors.dart';
import 'package:store_manage/core/constants/app_numbers.dart';
import 'package:store_manage/core/constants/app_strings.dart';
import 'package:store_manage/core/widgets/app_search_field.dart';

class InventorySearchBar extends StatelessWidget {
  final TextEditingController controller;
  final ValueChanged<String> onChanged;

  const InventorySearchBar({super.key, required this.controller, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return AppSearchField(
      controller: controller,
      hintText: AppStrings.homeProductSearchPlaceholder,
      iconColor: AppColors.textMuted,
      onChanged: onChanged,
      trailing: const Icon(Icons.qr_code_scanner, size: AppNumbers.DOUBLE_20, color: AppColors.textSecondary),
    );
  }
}
