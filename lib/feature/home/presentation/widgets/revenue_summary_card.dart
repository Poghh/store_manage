import 'package:flutter/material.dart';

import 'package:store_manage/core/constants/app_colors.dart';
import 'package:store_manage/core/constants/app_font_sizes.dart';
import 'package:store_manage/core/constants/app_fonts.dart';
import 'package:store_manage/core/constants/app_numbers.dart';
import 'package:store_manage/core/widgets/app_surface_card.dart';

class RevenueSummaryCard extends StatelessWidget {
  final String title;
  final String revenueText;
  final bool isLoading;
  final VoidCallback? onTap;

  const RevenueSummaryCard({
    super.key,
    required this.title,
    required this.revenueText,
    this.isLoading = false,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.surface,
      borderRadius: BorderRadius.circular(AppNumbers.DOUBLE_12),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(AppNumbers.DOUBLE_12),
        child: AppSurfaceCard(
          padding: const EdgeInsets.all(AppNumbers.DOUBLE_16),
          boxShadow: const [
            BoxShadow(
              color: AppColors.border,
              blurRadius: AppNumbers.DOUBLE_8,
              offset: Offset(AppNumbers.DOUBLE_0, AppNumbers.DOUBLE_4),
            ),
          ],
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                        fontSize: AppFontSizes.fontSize22,
                        fontWeight: FontWeight.w500,
                        fontFamily: AppFonts.inter,
                        color: AppColors.primaryDark,
                      ),
                    ),
                    const SizedBox(height: AppNumbers.DOUBLE_8),
                    isLoading
                        ? const SizedBox(
                            height: AppNumbers.DOUBLE_24,
                            width: AppNumbers.DOUBLE_24,
                            child: CircularProgressIndicator(strokeWidth: AppNumbers.DOUBLE_2),
                          )
                        : Text(
                            revenueText,
                            style: TextStyle(
                              fontSize: AppFontSizes.fontSize22,
                              fontWeight: FontWeight.w700,
                              fontFamily: AppFonts.inter,
                              color: AppColors.primaryDark,
                            ),
                          ),
                  ],
                ),
              ),
              Container(
                height: AppNumbers.DOUBLE_65,
                width: AppNumbers.DOUBLE_65,
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(AppNumbers.DOUBLE_12)),
                child: Icon(
                  Icons.account_balance_wallet_outlined,
                  size: AppNumbers.DOUBLE_60,
                  color: AppColors.primary,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
