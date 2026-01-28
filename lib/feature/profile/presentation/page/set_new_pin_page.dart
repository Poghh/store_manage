import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';
import 'package:store_manage/core/DI/di.dart';
import 'package:store_manage/core/constants/app_colors.dart';
import 'package:store_manage/core/constants/app_font_sizes.dart';
import 'package:store_manage/core/constants/app_fonts.dart';
import 'package:store_manage/core/constants/app_numbers.dart';
import 'package:store_manage/core/constants/app_strings.dart';
import 'package:store_manage/core/data/storage/secure_storage.dart';
import 'package:store_manage/core/utils/app_toast.dart';

@RoutePage()
class SetNewPinPage extends StatefulWidget {
  const SetNewPinPage({super.key});

  @override
  State<SetNewPinPage> createState() => _SetNewPinPageState();
}

class _SetNewPinPageState extends State<SetNewPinPage> {
  final _controller = TextEditingController();
  final _focusNode = FocusNode();
  String? _errorText;
  bool _isLoading = false;
  bool _isConfirmStep = false;
  String _newPin = '';

  @override
  void dispose() {
    _controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  Future<void> _onSubmit() async {
    if (_controller.text.length != AppNumbers.INT_4) return;

    if (!_isConfirmStep) {
      // Step 1: Save new PIN and move to confirm step
      setState(() {
        _newPin = _controller.text;
        _isConfirmStep = true;
        _controller.clear();
        _errorText = null;
      });
      _focusNode.requestFocus();
    } else {
      // Step 2: Verify confirm PIN matches
      if (_controller.text == _newPin) {
        setState(() => _isLoading = true);

        final secureStorage = di<SecureStorageImpl>();
        await secureStorage.savePin(_newPin);

        if (mounted) {
          AppToast.success(context, AppStrings.changePinSuccessMessage);
          // Pop both SetNewPinPage and VerifyCurrentPinPage
          context.router.popUntilRoot();
        }
      } else {
        setState(() {
          _errorText = AppStrings.setNewPinMismatchError;
          _controller.clear();
          // Go back to first step
          _isConfirmStep = false;
          _newPin = '';
        });
        _focusNode.requestFocus();
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

    final title = _isConfirmStep ? AppStrings.setNewPinConfirmTitle : AppStrings.setNewPinTitle;
    final subtitle = _isConfirmStep ? AppStrings.setNewPinConfirmSubtitle : AppStrings.setNewPinSubtitle;

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
                _isConfirmStep ? Icons.lock_reset : Icons.lock_outline,
                size: AppNumbers.DOUBLE_64,
                color: AppColors.primary,
              ),
              SizedBox(height: AppNumbers.DOUBLE_24),
              Text(
                title,
                style: TextStyle(
                  fontSize: AppFontSizes.fontSize24,
                  fontWeight: FontWeight.w700,
                  fontFamily: AppFonts.inter,
                  color: AppColors.textPrimary,
                ),
              ),
              SizedBox(height: AppNumbers.DOUBLE_8),
              Text(
                subtitle,
                style: TextStyle(
                  fontSize: AppFontSizes.fontSize14,
                  fontFamily: AppFonts.inter,
                  color: AppColors.textSecondary,
                ),
                textAlign: TextAlign.center,
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
                  textAlign: TextAlign.center,
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
                onCompleted: (_) => _onSubmit(),
              ),
              SizedBox(height: AppNumbers.DOUBLE_32),
              SizedBox(
                width: double.infinity,
                height: AppNumbers.DOUBLE_52,
                child: ElevatedButton(
                  onPressed: (_controller.text.length == AppNumbers.INT_4 && !_isLoading) ? _onSubmit : null,
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
                          _isConfirmStep ? AppStrings.setNewPinButton : AppStrings.verifyCurrentPinButton,
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
