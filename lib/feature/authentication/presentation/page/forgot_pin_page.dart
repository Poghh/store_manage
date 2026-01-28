import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:store_manage/core/constants/app_colors.dart';
import 'package:store_manage/core/constants/app_font_sizes.dart';
import 'package:store_manage/core/constants/app_fonts.dart';
import 'package:store_manage/core/constants/app_numbers.dart';
import 'package:store_manage/core/constants/app_strings.dart';
import 'package:store_manage/core/data/database/app_database.dart';
import 'package:store_manage/core/platform/biometric_service.dart';
import 'package:store_manage/core/DI/di.dart';
import 'package:store_manage/core/navigation/app_router.dart';
import 'package:store_manage/core/data/storage/secure_storage.dart';
import 'package:store_manage/core/utils/app_dialog.dart';
import 'package:store_manage/core/utils/app_toast.dart';

@RoutePage()
class ForgotPinPage extends StatefulWidget {
  const ForgotPinPage({super.key});

  @override
  State<ForgotPinPage> createState() => _ForgotPinPageState();
}

class _ForgotPinPageState extends State<ForgotPinPage> {
  bool _biometricAvailable = false;

  @override
  void initState() {
    super.initState();
    _checkBiometric();
  }

  Future<void> _checkBiometric() async {
    final available = await di<BiometricService>().isAvailable();
    if (mounted) {
      setState(() => _biometricAvailable = available);
    }
  }

  Future<void> _onVerifyPhone() async {
    context.router.push(const VerifyPhoneRoute());
  }

  Future<void> _onBiometricAuth() async {
    final biometricService = di<BiometricService>();

    if (!await biometricService.isAvailable()) {
      if (mounted) {
        AppToast.error(context, AppStrings.forgotPinBiometricNotAvailable);
      }
      return;
    }

    final authenticated = await biometricService.authenticate(reason: AppStrings.forgotPinBiometricReason);

    if (authenticated && mounted) {
      context.router.push(const SetNewPinRoute());
    } else if (mounted) {
      AppToast.error(context, AppStrings.forgotPinBiometricFailed);
    }
  }

  Future<void> _onResetAllData() async {
    final confirmed = await AppDialog.confirmAsync(
      context: context,
      title: AppStrings.forgotPinResetDialogTitle,
      message: AppStrings.forgotPinResetDialogMessage,
      confirmText: AppStrings.forgotPinResetDialogConfirm,
      cancelText: AppStrings.forgotPinResetDialogCancel,
      type: AppDialogType.error,
    );

    if (confirmed && mounted) {
      await di<SecureStorageImpl>().removeAllAsync();
      await di<AppDatabase>().clearAllStorageData();

      if (mounted) {
        context.router.replaceAll([const PhoneInputRoute()]);
      }
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
        scrolledUnderElevation: AppNumbers.DOUBLE_0,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(AppNumbers.DOUBLE_24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(Icons.lock_reset, size: AppNumbers.DOUBLE_64, color: AppColors.primary),
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
                ),
              ),
              SizedBox(height: AppNumbers.DOUBLE_32),

              // Option 1: Biometric (only show if available)
              if (_biometricAvailable) ...[
                _buildOptionCard(
                  icon: Icons.fingerprint,
                  title: AppStrings.forgotPinOptionBiometricTitle,
                  description: AppStrings.forgotPinOptionBiometricDesc,
                  onTap: _onBiometricAuth,
                ),
                SizedBox(height: AppNumbers.DOUBLE_16),
              ],

              // Option 2: Verify phone
              _buildOptionCard(
                icon: Icons.phone_android,
                title: AppStrings.forgotPinOptionVerifyTitle,
                description: AppStrings.forgotPinOptionVerifyDesc,
                onTap: _onVerifyPhone,
              ),

              SizedBox(height: AppNumbers.DOUBLE_16),

              // Option 3: Reset all data
              _buildOptionCard(
                icon: Icons.delete_forever,
                title: AppStrings.forgotPinOptionResetTitle,
                description: AppStrings.forgotPinOptionResetDesc,
                onTap: _onResetAllData,
                isDanger: true,
              ),

              SizedBox(height: AppNumbers.DOUBLE_32),

              // Cancel button
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

  Widget _buildOptionCard({
    required IconData icon,
    required String title,
    required String description,
    required VoidCallback onTap,
    bool isDanger = false,
  }) {
    final color = isDanger ? AppColors.error : AppColors.primary;

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(AppNumbers.DOUBLE_16),
      child: Container(
        padding: EdgeInsets.all(AppNumbers.DOUBLE_16),
        decoration: BoxDecoration(
          border: Border.all(color: color.withValues(alpha: 0.3), width: 1.5),
          borderRadius: BorderRadius.circular(AppNumbers.DOUBLE_16),
        ),
        child: Row(
          children: [
            Container(
              width: AppNumbers.DOUBLE_48,
              height: AppNumbers.DOUBLE_48,
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(AppNumbers.DOUBLE_12),
              ),
              child: Icon(icon, size: AppNumbers.DOUBLE_24, color: color),
            ),
            SizedBox(width: AppNumbers.DOUBLE_16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: AppFontSizes.fontSize16,
                      fontWeight: FontWeight.w600,
                      fontFamily: AppFonts.inter,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  SizedBox(height: AppNumbers.DOUBLE_4),
                  Text(
                    description,
                    style: TextStyle(
                      fontSize: AppFontSizes.fontSize12,
                      fontFamily: AppFonts.inter,
                      color: AppColors.textSecondary,
                    ),
                  ),
                ],
              ),
            ),
            Icon(Icons.chevron_right, color: AppColors.textSecondary),
          ],
        ),
      ),
    );
  }
}
