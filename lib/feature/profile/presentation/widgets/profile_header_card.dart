import 'dart:io';

import 'package:flutter/material.dart';

import 'package:store_manage/core/constants/app_colors.dart';
import 'package:store_manage/core/constants/app_font_sizes.dart';
import 'package:store_manage/core/constants/app_fonts.dart';
import 'package:store_manage/core/constants/app_numbers.dart';
import 'package:store_manage/core/widgets/app_surface_card.dart';

class ProfileHeaderCard extends StatelessWidget {
  final String name;
  final String email;
  final String? avatarPath;

  const ProfileHeaderCard({super.key, required this.name, required this.email, this.avatarPath});

  @override
  Widget build(BuildContext context) {
    final hasAvatar = avatarPath != null && avatarPath!.isNotEmpty;

    return AppSurfaceCard(
      padding: const EdgeInsets.all(AppNumbers.DOUBLE_16),
      child: Row(
        children: [
          Container(
            width: AppNumbers.DOUBLE_64,
            height: AppNumbers.DOUBLE_64,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: AppColors.primary.withValues(alpha: 0.1),
            ),
            child: ClipOval(
              child: hasAvatar
                  ? Image.file(
                      File(avatarPath!),
                      fit: BoxFit.cover,
                      width: AppNumbers.DOUBLE_64,
                      height: AppNumbers.DOUBLE_64,
                      errorBuilder: (context, error, stackTrace) => _buildAvatarPlaceholder(),
                    )
                  : _buildAvatarPlaceholder(),
            ),
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

  Widget _buildAvatarPlaceholder() {
    return Container(
      color: AppColors.primary.withValues(alpha: 0.1),
      child: const Icon(
        Icons.person_outline,
        size: AppNumbers.DOUBLE_32,
        color: AppColors.primary,
      ),
    );
  }
}
