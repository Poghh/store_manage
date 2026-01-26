import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:store_manage/core/constants/app_colors.dart';
import 'package:store_manage/core/constants/app_font_sizes.dart';
import 'package:store_manage/core/constants/app_fonts.dart';
import 'package:store_manage/core/constants/app_numbers.dart';
import 'package:store_manage/core/constants/app_strings.dart';
import 'package:store_manage/core/DI/di.dart';
import 'package:store_manage/core/navigation/app_router.dart';
import 'package:store_manage/core/storage/secure_storage.dart';

@RoutePage()
class ForgotPinPage extends StatelessWidget {
  const ForgotPinPage({super.key});

  Future<void> _onConfirmReset(BuildContext context) async {
    await di<SecureStorageImpl>().clearPhoneNumber();
    if (context.mounted) {
      context.router.replaceAll([const PhoneInputRoute()]);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: AppNumbers.DOUBLE_0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: AppColors.textPrimary),
          onPressed: () => context.router.pop(),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(AppNumbers.DOUBLE_24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(
                Icons.lock_reset,
                size: AppNumbers.DOUBLE_64,
                color: AppColors.primary,
              ),
              SizedBox(height: AppNumbers.DOUBLE_24),
              Text(
                AppStrings.forgotPinPageTitle,
                style: TextStyle(
                  fontSize: AppFontSizes.fontSize24,
                  fontWeight: FontWeight.w700,
                  fontFamily: AppFonts.inter,
                  color: AppColors.textPrimary,
                ),
              ),
              SizedBox(height: AppNumbers.DOUBLE_12),
              Text(
                AppStrings.forgotPinPageDescription,
                style: TextStyle(
                  fontSize: AppFontSizes.fontSize14,
                  fontFamily: AppFonts.inter,
                  color: AppColors.textSecondary,
                  height: 1.5,
                ),
              ),
              SizedBox(height: AppNumbers.DOUBLE_32),
              _buildInfoItem(
                icon: Icons.phone_android,
                text: AppStrings.forgotPinStep1,
              ),
              SizedBox(height: AppNumbers.DOUBLE_16),
              _buildInfoItem(
                icon: Icons.pin,
                text: AppStrings.forgotPinStep2,
              ),
              SizedBox(height: AppNumbers.DOUBLE_16),
              _buildInfoItem(
                icon: Icons.check_circle_outline,
                text: AppStrings.forgotPinStep3,
              ),
              Spacer(),
              SizedBox(
                width: double.infinity,
                height: AppNumbers.DOUBLE_52,
                child: ElevatedButton(
                  onPressed: () => _onConfirmReset(context),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    foregroundColor: AppColors.textOnPrimary,
                    elevation: AppNumbers.DOUBLE_0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(AppNumbers.DOUBLE_16),
                    ),
                  ),
                  child: Text(
                    AppStrings.forgotPinConfirmButton,
                    style: TextStyle(
                      fontSize: AppFontSizes.fontSize16,
                      fontWeight: FontWeight.w600,
                      fontFamily: AppFonts.inter,
                    ),
                  ),
                ),
              ),
              SizedBox(height: AppNumbers.DOUBLE_12),
              SizedBox(
                width: double.infinity,
                height: AppNumbers.DOUBLE_52,
                child: TextButton(
                  onPressed: () => context.router.pop(),
                  child: Text(
                    AppStrings.forgotPinCancelButton,
                    style: TextStyle(
                      fontSize: AppFontSizes.fontSize16,
                      fontFamily: AppFonts.inter,
                      color: AppColors.textSecondary,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInfoItem({required IconData icon, required String text}) {
    return Row(
      children: [
        Container(
          width: AppNumbers.DOUBLE_40,
          height: AppNumbers.DOUBLE_40,
          decoration: BoxDecoration(
            color: AppColors.primary.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(AppNumbers.DOUBLE_12),
          ),
          child: Icon(
            icon,
            size: AppNumbers.DOUBLE_20,
            color: AppColors.primary,
          ),
        ),
        SizedBox(width: AppNumbers.DOUBLE_12),
        Expanded(
          child: Text(
            text,
            style: TextStyle(
              fontSize: AppFontSizes.fontSize14,
              fontFamily: AppFonts.inter,
              color: AppColors.textPrimary,
            ),
          ),
        ),
      ],
    );
  }
}
