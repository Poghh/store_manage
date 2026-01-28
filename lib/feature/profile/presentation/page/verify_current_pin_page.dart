import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';
import 'package:store_manage/core/DI/di.dart';
import 'package:store_manage/core/constants/app_colors.dart';
import 'package:store_manage/core/constants/app_font_sizes.dart';
import 'package:store_manage/core/constants/app_fonts.dart';
import 'package:store_manage/core/constants/app_numbers.dart';
import 'package:store_manage/core/constants/app_strings.dart';
import 'package:store_manage/core/navigation/app_router.dart';
import 'package:store_manage/core/data/storage/secure_storage.dart';

@RoutePage()
class VerifyCurrentPinPage extends StatefulWidget {
  const VerifyCurrentPinPage({super.key});

  @override
  State<VerifyCurrentPinPage> createState() => _VerifyCurrentPinPageState();
}

class _VerifyCurrentPinPageState extends State<VerifyCurrentPinPage> {
  final _controller = TextEditingController();
  final _focusNode = FocusNode();
  String? _errorText;
  bool _isLoading = false;

  @override
  void dispose() {
    _controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  Future<void> _onVerify() async {
    if (_controller.text.length != AppNumbers.INT_4) return;

    setState(() {
      _isLoading = true;
      _errorText = null;
    });

    final secureStorage = di<SecureStorageImpl>();
    final storedPin = await secureStorage.getPin();

    if (storedPin == _controller.text) {
      if (mounted) {
        context.router.push(const SetNewPinRoute());
      }
    } else {
      if (mounted) {
        setState(() {
          _isLoading = false;
          _errorText = AppStrings.verifyCurrentPinError;
          _controller.clear();
        });
      }
    }
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

    final errorPinTheme = defaultPinTheme.copyWith(
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(AppNumbers.DOUBLE_14),
        border: Border.all(color: AppColors.error),
      ),
    );

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text(AppStrings.changePinTitle),
        backgroundColor: AppColors.primary,
        foregroundColor: AppColors.textOnPrimary,
      ),
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
                AppStrings.verifyCurrentPinTitle,
                style: TextStyle(
                  fontSize: AppFontSizes.fontSize24,
                  fontWeight: FontWeight.w700,
                  fontFamily: AppFonts.inter,
                  color: AppColors.textPrimary,
                ),
              ),
              SizedBox(height: AppNumbers.DOUBLE_8),
              Text(
                AppStrings.verifyCurrentPinSubtitle,
                style: TextStyle(
                  fontSize: AppFontSizes.fontSize14,
                  fontFamily: AppFonts.inter,
                  color: AppColors.textSecondary,
                ),
              ),
              if (_errorText != null) ...[
                SizedBox(height: AppNumbers.DOUBLE_8),
                Text(
                  _errorText!,
                  style: TextStyle(
                    fontSize: AppFontSizes.fontSize14,
                    fontFamily: AppFonts.inter,
                    color: AppColors.error,
                  ),
                ),
              ],
              SizedBox(height: AppNumbers.DOUBLE_32),
              Pinput(
                length: AppNumbers.INT_4,
                controller: _controller,
                focusNode: _focusNode,
                obscureText: true,
                obscuringCharacter: '●',
                autofocus: true,
                defaultPinTheme: _errorText != null ? errorPinTheme : defaultPinTheme,
                focusedPinTheme: _errorText != null ? errorPinTheme : focusedPinTheme,
                submittedPinTheme: _errorText != null ? errorPinTheme : submittedPinTheme,
                separatorBuilder: (index) => SizedBox(width: AppNumbers.DOUBLE_12),
                onChanged: (value) {
                  if (value.isNotEmpty && _errorText != null) {
                    setState(() => _errorText = null);
                  } else {
                    setState(() {});
                  }
                },
                onCompleted: (_) => _onVerify(),
              ),
              SizedBox(height: AppNumbers.DOUBLE_32),
              SizedBox(
                width: double.infinity,
                height: AppNumbers.DOUBLE_52,
                child: ElevatedButton(
                  onPressed: (_controller.text.length == AppNumbers.INT_4 && !_isLoading) ? _onVerify : null,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    foregroundColor: AppColors.textOnPrimary,
                    disabledBackgroundColor: AppColors.primary.withValues(alpha: 0.5),
                    disabledForegroundColor: AppColors.textOnPrimary.withValues(alpha: 0.7),
                    elevation: AppNumbers.DOUBLE_0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(AppNumbers.DOUBLE_16),
                    ),
                  ),
                  child: _isLoading
                      ? SizedBox(
                          width: AppNumbers.DOUBLE_20,
                          height: AppNumbers.DOUBLE_20,
                          child: CircularProgressIndicator(
                            strokeWidth: AppNumbers.DOUBLE_2,
                            color: AppColors.textOnPrimary,
                          ),
                        )
                      : Text(
                          AppStrings.verifyCurrentPinButton,
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
