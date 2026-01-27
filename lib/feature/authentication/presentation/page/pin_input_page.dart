import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';
import 'package:store_manage/core/constants/app_colors.dart';
import 'package:store_manage/core/constants/app_font_sizes.dart';
import 'package:store_manage/core/constants/app_fonts.dart';
import 'package:store_manage/core/constants/app_numbers.dart';
import 'package:store_manage/core/constants/app_strings.dart';
import 'package:store_manage/core/navigation/app_router.dart';

@RoutePage()
class PinInputPage extends StatefulWidget {
  final String phoneNumber;

  const PinInputPage({super.key, required this.phoneNumber});

  @override
  State<PinInputPage> createState() => _PinInputPageState();
}

class _PinInputPageState extends State<PinInputPage> {
  final _controller = TextEditingController();
  final _focusNode = FocusNode();

  @override
  void dispose() {
    _controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  void _onLogin() {
    if (_controller.text.length == AppNumbers.INT_4) {
      context.router.replaceAll([const HomeTabsRoute()]);
    }
  }

  void _onForgotPin() {
    context.router.push(const ForgotPinRoute());
  }

  @override
  Widget build(BuildContext context) {
    final defaultPinTheme = PinTheme(
      width: AppNumbers.DOUBLE_56,
      height: AppNumbers.DOUBLE_56,
      textStyle: TextStyle(
        fontSize: AppFontSizes.fontSize24,
        fontWeight: FontWeight.w600,
        fontFamily: AppFonts.inter,
        color: AppColors.textPrimary,
      ),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(AppNumbers.DOUBLE_14),
        border: Border.all(color: AppColors.border),
      ),
    );

    final focusedPinTheme = defaultPinTheme.copyWith(
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(AppNumbers.DOUBLE_14),
        border: Border.all(color: AppColors.primary, width: AppNumbers.DOUBLE_2),
      ),
    );

    final submittedPinTheme = defaultPinTheme.copyWith(
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(AppNumbers.DOUBLE_14),
        border: Border.all(color: AppColors.primary),
      ),
    );

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: AppNumbers.DOUBLE_24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.lock_outline,
                size: AppNumbers.DOUBLE_64,
                color: AppColors.primary,
              ),
              SizedBox(height: AppNumbers.DOUBLE_24),
              Text(
                AppStrings.loginPinTitle,
                style: TextStyle(
                  fontSize: AppFontSizes.fontSize24,
                  fontWeight: FontWeight.w700,
                  fontFamily: AppFonts.inter,
                  color: AppColors.textPrimary,
                ),
              ),
              SizedBox(height: AppNumbers.DOUBLE_8),
              Text(
                AppStrings.loginPinSubtitle,
                style: TextStyle(
                  fontSize: AppFontSizes.fontSize14,
                  fontFamily: AppFonts.inter,
                  color: AppColors.textSecondary,
                ),
              ),
              SizedBox(height: AppNumbers.DOUBLE_32),
              Pinput(
                length: AppNumbers.INT_4,
                controller: _controller,
                focusNode: _focusNode,
                obscureText: true,
                obscuringCharacter: '●',
                autofocus: true,
                defaultPinTheme: defaultPinTheme,
                focusedPinTheme: focusedPinTheme,
                submittedPinTheme: submittedPinTheme,
                separatorBuilder: (index) => SizedBox(width: AppNumbers.DOUBLE_12),
                onChanged: (_) => setState(() {}),
                onCompleted: (_) => _onLogin(),
              ),
              SizedBox(height: AppNumbers.DOUBLE_32),
              SizedBox(
                width: double.infinity,
                height: AppNumbers.DOUBLE_52,
                child: ElevatedButton(
                  onPressed: _controller.text.length == AppNumbers.INT_4 ? _onLogin : null,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    foregroundColor: AppColors.textOnPrimary,
                    disabledBackgroundColor:
                        AppColors.primary.withValues(alpha: 0.5),
                    disabledForegroundColor:
                        AppColors.textOnPrimary.withValues(alpha: 0.7),
                    elevation: AppNumbers.DOUBLE_0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(AppNumbers.DOUBLE_16),
                    ),
                  ),
                  child: Text(
                    AppStrings.loginPinButton,
                    style: TextStyle(
                      fontSize: AppFontSizes.fontSize16,
                      fontWeight: FontWeight.w600,
                      fontFamily: AppFonts.inter,
                    ),
                  ),
                ),
              ),
              SizedBox(height: AppNumbers.DOUBLE_16),
              TextButton(
                onPressed: _onForgotPin,
                child: Text(
                  AppStrings.loginPinForgotButton,
                  style: TextStyle(
                    fontSize: AppFontSizes.fontSize14,
                    fontFamily: AppFonts.inter,
                    color: AppColors.textSecondary,
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
