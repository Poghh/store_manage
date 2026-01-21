import 'package:flutter/material.dart';

import 'package:store_manage/core/constants/app_colors.dart';
import 'package:store_manage/core/constants/app_font_sizes.dart';
import 'package:store_manage/core/constants/app_fonts.dart';
import 'package:store_manage/core/constants/app_numbers.dart';
import 'package:store_manage/core/constants/app_strings.dart';
import 'package:store_manage/core/widgets/app_surface_card.dart';

class ProfileLogoutCard extends StatelessWidget {
  const ProfileLogoutCard({super.key});

  @override
  Widget build(BuildContext context) {
    return const AppSurfaceCard(
      padding: EdgeInsets.all(AppNumbers.DOUBLE_12),
      child: Row(
        children: [
          Icon(Icons.logout, color: AppColors.primary),
          SizedBox(width: AppNumbers.DOUBLE_12),
          Text(
            AppStrings.profileLogout,
            style: TextStyle(
              fontSize: AppFontSizes.fontSize14,
              fontWeight: FontWeight.w600,
              fontFamily: AppFonts.inter,
              color: AppColors.primary,
            ),
          ),
        ],
      ),
    );
  }
}
