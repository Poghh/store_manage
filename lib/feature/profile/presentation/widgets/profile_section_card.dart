import 'package:flutter/material.dart';

import 'package:store_manage/core/constants/app_colors.dart';
import 'package:store_manage/core/constants/app_font_sizes.dart';
import 'package:store_manage/core/constants/app_fonts.dart';
import 'package:store_manage/core/constants/app_numbers.dart';
import 'package:store_manage/core/widgets/app_surface_card.dart';

class ProfileSectionCard extends StatelessWidget {
  final String title;
  final List<ProfileItem> items;
  final void Function(ProfileItem)? onItemTap;

  const ProfileSectionCard({super.key, required this.title, required this.items, this.onItemTap});

  @override
  Widget build(BuildContext context) {
    return AppSurfaceCard(
      padding: const EdgeInsets.all(AppNumbers.DOUBLE_12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: AppFontSizes.fontSize12,
              fontWeight: FontWeight.w600,
              fontFamily: AppFonts.inter,
              color: AppColors.textSecondary,
            ),
          ),
          const SizedBox(height: AppNumbers.DOUBLE_8),
          ...items.map(
            (item) => Padding(
              padding: const EdgeInsets.symmetric(vertical: AppNumbers.DOUBLE_4),
              child: InkWell(
                onTap: onItemTap == null ? null : () => onItemTap!(item),
                child: Row(
                  children: [
                    Icon(item.icon, color: AppColors.primary, size: AppNumbers.DOUBLE_20),
                    const SizedBox(width: AppNumbers.DOUBLE_12),
                    Expanded(
                      child: Text(
                        item.label,
                        style: const TextStyle(
                          fontSize: AppFontSizes.fontSize14,
                          fontWeight: FontWeight.w600,
                          fontFamily: AppFonts.inter,
                          color: AppColors.textPrimary,
                        ),
                      ),
                    ),
                    const Icon(Icons.chevron_right, color: AppColors.textMuted),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ProfileItem {
  final String label;
  final IconData icon;

  const ProfileItem({required this.label, required this.icon});
}
