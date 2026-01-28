import 'package:flutter/material.dart';

import 'package:store_manage/core/constants/app_colors.dart';
import 'package:store_manage/core/constants/app_numbers.dart';

class HomeActionCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final Color backgroundColor;
  final IconData icon;
  final Color iconBackground;
  final Color titleColor;
  final Color subtitleColor;
  final Color iconColor;
  final Color arrowBackgroundColor;
  final Color arrowIconColor;

  const HomeActionCard({
    super.key,
    required this.title,
    required this.subtitle,
    required this.backgroundColor,
    required this.icon,
    required this.iconBackground,
    this.titleColor = AppColors.textPrimary,
    this.subtitleColor = AppColors.textSecondary,
    this.iconColor = AppColors.textOnPrimary,
    this.arrowBackgroundColor = AppColors.surface,
    this.arrowIconColor = AppColors.textSecondary,
  });

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Container(
      padding: const EdgeInsets.all(AppNumbers.DOUBLE_16),
      decoration: BoxDecoration(color: backgroundColor, borderRadius: BorderRadius.circular(AppNumbers.DOUBLE_12)),
      child: Row(
        children: [
          Container(
            height: AppNumbers.DOUBLE_48,
            width: AppNumbers.DOUBLE_48,
            decoration: BoxDecoration(color: iconBackground, borderRadius: BorderRadius.circular(AppNumbers.DOUBLE_12)),
            child: Icon(icon, color: iconColor, size: AppNumbers.DOUBLE_24),
          ),
          const SizedBox(width: AppNumbers.DOUBLE_12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w700,
                    color: titleColor,
                  ),
                ),
                const SizedBox(height: AppNumbers.DOUBLE_4),
                Text(subtitle, style: textTheme.labelMedium?.copyWith(color: subtitleColor)),
              ],
            ),
          ),
          Container(
            height: AppNumbers.DOUBLE_32,
            width: AppNumbers.DOUBLE_32,
            decoration: BoxDecoration(
              color: arrowBackgroundColor,
              borderRadius: BorderRadius.circular(AppNumbers.DOUBLE_8),
            ),
            child: Icon(Icons.arrow_forward_ios, size: AppNumbers.DOUBLE_14, color: arrowIconColor),
          ),
        ],
      ),
    );
  }
}
