import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:store_manage/core/DI/di.dart';
import 'package:store_manage/core/constants/app_colors.dart';
import 'package:store_manage/core/constants/app_numbers.dart';
import 'package:store_manage/core/constants/app_strings.dart';
import 'package:store_manage/core/navigation/app_router.dart';
import 'package:store_manage/core/data/storage/secure_storage.dart';

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
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      backgroundColor: AppColors.background,
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
              Text(AppStrings.loginPhoneTitle, style: textTheme.displayMedium),
              SizedBox(height: AppNumbers.DOUBLE_8),
              Text(AppStrings.loginPhoneSubtitle, style: textTheme.bodyMedium),
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
                  hintStyle: textTheme.bodyLarge?.copyWith(color: AppColors.textMuted),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(AppNumbers.DOUBLE_16),
                    borderSide: BorderSide(color: AppColors.border),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(AppNumbers.DOUBLE_16),
                    borderSide: BorderSide(color: AppColors.primary),
                  ),
                ),
                style: textTheme.bodyLarge,
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
                    disabledBackgroundColor: AppColors.primary.withValues(alpha: 0.5),
                    disabledForegroundColor: AppColors.textOnPrimary.withValues(alpha: 0.7),
                    elevation: AppNumbers.DOUBLE_0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(AppNumbers.DOUBLE_16),
                    ),
                  ),
                  child: Text(AppStrings.loginPhoneContinueButton, style: textTheme.titleMedium?.copyWith(color: AppColors.textOnPrimary)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
