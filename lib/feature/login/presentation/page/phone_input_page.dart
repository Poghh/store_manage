import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:store_manage/core/DI/di.dart';
import 'package:store_manage/core/constants/app_colors.dart';
import 'package:store_manage/core/constants/app_font_sizes.dart';
import 'package:store_manage/core/constants/app_fonts.dart';
import 'package:store_manage/core/constants/app_numbers.dart';
import 'package:store_manage/core/constants/app_strings.dart';
import 'package:store_manage/core/navigation/app_router.dart';
import 'package:store_manage/core/storage/secure_storage.dart';

@RoutePage()
class PhoneInputPage extends StatefulWidget {
  const PhoneInputPage({super.key});

  @override
  State<PhoneInputPage> createState() => _PhoneInputPageState();
}

class _PhoneInputPageState extends State<PhoneInputPage> {
  final _controller = TextEditingController();
  final _focusNode = FocusNode();

  @override
  void dispose() {
    _controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  Future<void> _onContinue() async {
    if (_controller.text.length >= AppNumbers.INT_10) {
      final secureStorage = di<SecureStorageImpl>();
      await secureStorage.savePhoneNumber(_controller.text);
      if (mounted) {
        context.router.push(PinInputRoute(phoneNumber: _controller.text));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: AppNumbers.DOUBLE_24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                AppStrings.loginPhoneTitle,
                style: TextStyle(
                  fontSize: AppFontSizes.fontSize24,
                  fontWeight: FontWeight.w700,
                  fontFamily: AppFonts.inter,
                  color: AppColors.textPrimary,
                ),
              ),
              SizedBox(height: AppNumbers.DOUBLE_8),
              Text(
                AppStrings.loginPhoneSubtitle,
                style: TextStyle(
                  fontSize: AppFontSizes.fontSize14,
                  fontFamily: AppFonts.inter,
                  color: AppColors.textSecondary,
                ),
              ),
              SizedBox(height: AppNumbers.DOUBLE_32),
              TextField(
                controller: _controller,
                focusNode: _focusNode,
                keyboardType: TextInputType.phone,
                maxLength: AppNumbers.INT_10,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                onChanged: (_) => setState(() {}),
                decoration: InputDecoration(
                  hintText: AppStrings.loginPhoneHint,
                  counterText: '',
                  filled: true,
                  fillColor: AppColors.surface,
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: AppNumbers.DOUBLE_16,
                    vertical: AppNumbers.DOUBLE_14,
                  ),
                  hintStyle: TextStyle(
                    fontSize: AppFontSizes.fontSize16,
                    fontFamily: AppFonts.inter,
                    color: AppColors.textMuted,
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(AppNumbers.DOUBLE_16),
                    borderSide: BorderSide(color: AppColors.border),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(AppNumbers.DOUBLE_16),
                    borderSide: BorderSide(color: AppColors.primary),
                  ),
                ),
                style: TextStyle(
                  fontSize: AppFontSizes.fontSize16,
                  fontFamily: AppFonts.inter,
                  color: AppColors.textPrimary,
                ),
              ),
              SizedBox(height: AppNumbers.DOUBLE_24),
              SizedBox(
                width: double.infinity,
                height: AppNumbers.DOUBLE_52,
                child: ElevatedButton(
                  onPressed: _controller.text.length >= AppNumbers.INT_10 ? _onContinue : null,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    foregroundColor: AppColors.textOnPrimary,
                    disabledBackgroundColor:
                        AppColors.primary.withValues(alpha: 0.5),
                    disabledForegroundColor:
                        AppColors.textOnPrimary.withValues(alpha: 0.7),
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(AppNumbers.DOUBLE_16),
                    ),
                  ),
                  child: Text(
                    AppStrings.loginPhoneContinueButton,
                    style: TextStyle(
                      fontSize: AppFontSizes.fontSize16,
                      fontWeight: FontWeight.w600,
                      fontFamily: AppFonts.inter,
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
}
