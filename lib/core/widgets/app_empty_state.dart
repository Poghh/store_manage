import 'package:flutter/material.dart';

import 'package:store_manage/core/constants/app_colors.dart';
import 'package:store_manage/core/constants/app_numbers.dart';

class AppEmptyState extends StatelessWidget {
  final String message;
  final IconData? icon;
  final double iconSize;
  final Color iconColor;
  final TextAlign textAlign;

  const AppEmptyState({
    super.key,
    required this.message,
    this.icon,
    this.iconSize = AppNumbers.DOUBLE_32,
    this.iconColor = AppColors.textSecondary,
    this.textAlign = TextAlign.center,
  });

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (icon != null) ...[
            Icon(icon, size: iconSize, color: iconColor),
            const SizedBox(height: AppNumbers.DOUBLE_8),
          ],
          Text(
            message,
            textAlign: textAlign,
            style: textTheme.labelLarge?.copyWith(color: AppColors.textSecondary),
          ),
        ],
      ),
    );
  }
}
