import 'package:flutter/material.dart';

import 'package:store_manage/core/constants/app_colors.dart';
import 'package:store_manage/core/constants/app_images.dart';
import 'package:store_manage/core/constants/app_numbers.dart';

class HomeHeader extends StatelessWidget {
  const HomeHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.primary,
      child: SafeArea(
        bottom: false,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppNumbers.DOUBLE_12),
          child: SizedBox(
            height: AppNumbers.DOUBLE_56,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset(AppImages.logo, width: AppNumbers.DOUBLE_120, height: AppNumbers.DOUBLE_120),
                const Spacer(),
                Container(
                  height: AppNumbers.DOUBLE_36,
                  width: AppNumbers.DOUBLE_36,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: AppColors.primaryLight, width: AppNumbers.DOUBLE_1),
                  ),
                  child: const Icon(
                    Icons.notifications_none,
                    color: AppColors.textOnPrimary,
                    size: AppNumbers.DOUBLE_22,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
