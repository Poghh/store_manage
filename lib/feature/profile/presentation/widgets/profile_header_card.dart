import 'package:flutter/material.dart';

import 'package:store_manage/core/constants/app_colors.dart';
import 'package:store_manage/core/constants/app_font_sizes.dart';
import 'package:store_manage/core/constants/app_fonts.dart';
import 'package:store_manage/core/constants/app_numbers.dart';
import 'package:store_manage/core/widgets/app_surface_card.dart';

class ProfileHeaderCard extends StatelessWidget {
  final String name;
  final String email;

  const ProfileHeaderCard({super.key, required this.name, required this.email});

  @override
  Widget build(BuildContext context) {
    return AppSurfaceCard(
      padding: const EdgeInsets.all(AppNumbers.DOUBLE_16),
      child: Row(
        children: [
          CircleAvatar(
            radius: AppNumbers.DOUBLE_32,
            backgroundColor: AppColors.primary.withValues(alpha: 0.1),
            child: const Icon(Icons.person_outline, size: AppNumbers.DOUBLE_32, color: AppColors.primary),
          ),
          const SizedBox(width: AppNumbers.DOUBLE_16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: const TextStyle(
                    fontSize: AppFontSizes.fontSize18,
                    fontWeight: FontWeight.w700,
                    fontFamily: AppFonts.inter,
                    color: AppColors.textPrimary,
                  ),
                ),
                const SizedBox(height: AppNumbers.DOUBLE_4),
                Text(
                  email,
                  style: const TextStyle(
                    fontSize: AppFontSizes.fontSize12,
                    fontWeight: FontWeight.w500,
                    fontFamily: AppFonts.inter,
                    color: AppColors.textSecondary,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
