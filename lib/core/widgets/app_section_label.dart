import 'package:flutter/material.dart';

import 'package:store_manage/core/constants/app_colors.dart';

class AppSectionLabel extends StatelessWidget {
  final String text;
  final Color color;

  const AppSectionLabel({
    super.key,
    required this.text,
    this.color = AppColors.textSecondary,
  });

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Text(text, style: textTheme.titleSmall?.copyWith(color: color));
  }
}
