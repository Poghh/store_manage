import 'package:flutter/material.dart';

import 'package:store_manage/core/constants/app_colors.dart';
import 'package:store_manage/core/constants/app_numbers.dart';

class AppPageHeader extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final List<Widget>? actions;

  const AppPageHeader({super.key, required this.title, this.actions});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return AppBar(
      backgroundColor: AppColors.background,
      elevation: AppNumbers.DOUBLE_0,
      scrolledUnderElevation: AppNumbers.DOUBLE_0,
      surfaceTintColor: AppColors.background,
      title: Text(title, style: textTheme.titleLarge),
      actions: actions,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
