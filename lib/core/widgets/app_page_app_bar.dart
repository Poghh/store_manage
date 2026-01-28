import 'package:flutter/material.dart';

import 'package:store_manage/core/constants/app_colors.dart';
import 'package:store_manage/core/constants/app_numbers.dart';

class AppPageAppBar extends StatelessWidget implements PreferredSizeWidget {
  final VoidCallback onBack;
  final String title;
  final List<Widget>? actions;

  const AppPageAppBar({super.key, required this.onBack, required this.title, this.actions});

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return AppBar(
      backgroundColor: AppColors.primary,
      elevation: AppNumbers.DOUBLE_0,
      scrolledUnderElevation: AppNumbers.DOUBLE_0,
      surfaceTintColor: AppColors.primary,
      leading: IconButton(
        onPressed: onBack,
        icon: const Icon(Icons.arrow_back, color: AppColors.textOnPrimary),
      ),
      title: Text(title, style: textTheme.titleLarge?.copyWith(color: AppColors.textOnPrimary)),
      actions: actions,
    );
  }
}
