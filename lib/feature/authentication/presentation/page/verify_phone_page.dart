import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:store_manage/core/DI/di.dart';
import 'package:store_manage/core/constants/app_colors.dart';
import 'package:store_manage/core/constants/app_font_sizes.dart';
import 'package:store_manage/core/constants/app_fonts.dart';
import 'package:store_manage/core/constants/app_numbers.dart';
import 'package:store_manage/core/constants/app_strings.dart';
import 'package:store_manage/core/navigation/app_router.dart';
import 'package:store_manage/core/storage/secure_storage.dart';

@RoutePage()
class VerifyPhonePage extends StatefulWidget {
  const VerifyPhonePage({super.key});

  @override
  State<VerifyPhonePage> createState() => _VerifyPhonePageState();
}

class _VerifyPhonePageState extends State<VerifyPhonePage> {
  final _controller = TextEditingController();
  final _focusNode = FocusNode();
  String? _errorText;
  bool _isVerifying = false;

  @override
  void dispose() {
    _controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  Future<void> _onVerify() async {
    if (_controller.text.length < AppNumbers.INT_10) return;

    setState(() {
      _isVerifying = true;
      _errorText = null;
    });

    // Get stored phone directly from FlutterSecureStorage (bypass expiration check)
    const storage = FlutterSecureStorage();
    final storedPhone = await storage.read(key: 'saved_phone_number');

    if (!mounted) return;

    if (storedPhone == _controller.text) {
      // Phone matches - clear old PIN and go to create new PIN
      await di<SecureStorageImpl>().clearPin();
      if (mounted) {
        context.router.replaceAll([PinInputRoute(phoneNumber: _controller.text)]);
      }
    } else {
      // Phone doesn't match
      setState(() {
        _isVerifying = false;
        _errorText = AppStrings.verifyPhoneError;
      });
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
          padding: EdgeInsets.symmetric(horizontal: AppNumbers.DOUBLE_24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.phone_android,
                size: AppNumbers.DOUBLE_64,
                color: AppColors.primary,
              ),
              SizedBox(height: AppNumbers.DOUBLE_24),
              Text(
                AppStrings.verifyPhoneTitle,
                style: TextStyle(
                  fontSize: AppFontSizes.fontSize24,
                  fontWeight: FontWeight.w700,
                  fontFamily: AppFonts.inter,
                  color: AppColors.textPrimary,
                ),
              ),
              SizedBox(height: AppNumbers.DOUBLE_8),
              Text(
                AppStrings.verifyPhoneSubtitle,
                style: TextStyle(
                  fontSize: AppFontSizes.fontSize14,
                  fontFamily: AppFonts.inter,
                  color: AppColors.textSecondary,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: AppNumbers.DOUBLE_32),
              TextField(
                controller: _controller,
                focusNode: _focusNode,
                keyboardType: TextInputType.phone,
                maxLength: AppNumbers.INT_10,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                onChanged: (_) => setState(() => _errorText = null),
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
                  errorText: _errorText,
                  errorStyle: TextStyle(
                    fontSize: AppFontSizes.fontSize12,
                    fontFamily: AppFonts.inter,
                    color: AppColors.error,
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(AppNumbers.DOUBLE_16),
                    borderSide: BorderSide(
                      color: _errorText != null ? AppColors.error : AppColors.border,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(AppNumbers.DOUBLE_16),
                    borderSide: BorderSide(
                      color: _errorText != null ? AppColors.error : AppColors.primary,
                    ),
                  ),
                  errorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(AppNumbers.DOUBLE_16),
                    borderSide: BorderSide(color: AppColors.error),
                  ),
                  focusedErrorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(AppNumbers.DOUBLE_16),
                    borderSide: BorderSide(color: AppColors.error),
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
                  onPressed: (_controller.text.length >= AppNumbers.INT_10 && !_isVerifying)
                      ? _onVerify
                      : null,
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
                  child: _isVerifying
                      ? SizedBox(
                          width: AppNumbers.DOUBLE_20,
                          height: AppNumbers.DOUBLE_20,
                          child: CircularProgressIndicator(
                            strokeWidth: AppNumbers.DOUBLE_2,
                            color: AppColors.textOnPrimary,
                          ),
                        )
                      : Text(
                          AppStrings.verifyPhoneButton,
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
