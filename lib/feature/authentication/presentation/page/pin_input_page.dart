import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';
import 'package:store_manage/core/DI/di.dart';
import 'package:store_manage/core/constants/app_colors.dart';
import 'package:store_manage/core/constants/app_numbers.dart';
import 'package:store_manage/core/constants/app_strings.dart';
import 'package:store_manage/core/data/repositories/app_credentials_repository.dart';
import 'package:store_manage/core/navigation/app_router.dart';
import 'package:store_manage/core/data/services/auth_token_service.dart';
import 'package:store_manage/core/data/storage/secure_storage.dart';

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
  String? _errorText;
  bool _isLoading = false;
  bool _isCreatingPin = false;

  @override
  void initState() {
    super.initState();
    _checkPinExists();
  }

  Future<void> _checkPinExists() async {
    final hasPin = await di<SecureStorageImpl>().hasPin();
    if (mounted) {
      setState(() {
        _isCreatingPin = !hasPin;
      });
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  Future<void> _onLogin() async {
    if (_controller.text.length != AppNumbers.INT_4) return;

    setState(() {
      _isLoading = true;
      _errorText = null;
    });

    final secureStorage = di<SecureStorageImpl>();
    final pin = _controller.text;

    // Luôn gọi API check phone exists trước
    final phoneExists = await _checkPhoneExistsOnServer();

    if (phoneExists == null) {
      // Network error → yêu cầu kết nối
      if (mounted) {
        setState(() => _isLoading = false);
        _showConnectivityRequiredDialog();
      }
      return;
    }

    // Lưu PIN và phone local
    await secureStorage.savePin(pin);
    await secureStorage.savePhoneNumber(widget.phoneNumber);

    if (!mounted) return;

    if (phoneExists) {
      // Account đã có trên server → lấy token và vào Home
      await di<AuthTokenService>().requestAppSecretAndToken(
        phone: widget.phoneNumber,
        pin: pin,
      );
      if (!mounted) return;
      context.router.replaceAll([const HomeTabsRoute()]);
    } else {
      // Account chưa có → vào SetupProfile để nhập thông tin và tạo credentials
      context.router.replaceAll([const SetupProfileRoute()]);
    }
  }

  /// Check if phone exists on server
  /// Returns: true (exists), false (not exists), null (network error)
  Future<bool?> _checkPhoneExistsOnServer() async {
    try {
      final exists = await di<AppCredentialsRepository>().checkPhoneExists(
        phone: widget.phoneNumber,
      );
      return exists;
    } catch (e) {
      // Network error or other exception
      return null;
    }
  }

  void _showConnectivityRequiredDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(AppStrings.connectivityRequiredTitle),
        content: Text(AppStrings.connectivityRequiredMessage),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text(AppStrings.connectivityRequiredButton),
          ),
        ],
      ),
    );
  }

  void _onForgotPin() {
    context.router.push(const ForgotPinRoute());
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    final defaultPinTheme = PinTheme(
      width: AppNumbers.DOUBLE_56,
      height: AppNumbers.DOUBLE_56,
      textStyle: textTheme.headlineLarge,
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
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: AppNumbers.DOUBLE_24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.lock_outline, size: AppNumbers.DOUBLE_64, color: AppColors.primary),
              SizedBox(height: AppNumbers.DOUBLE_24),
              Text(AppStrings.loginPinTitle, style: textTheme.displayMedium),
              SizedBox(height: AppNumbers.DOUBLE_8),
              Text(
                _isCreatingPin ? AppStrings.loginPinCreateSubtitle : AppStrings.loginPinSubtitle,
                style: textTheme.bodyMedium,
              ),
              if (_errorText != null) ...[
                SizedBox(height: AppNumbers.DOUBLE_8),
                Text(_errorText!, style: textTheme.bodyMedium?.copyWith(color: AppColors.error)),
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
                onCompleted: (_) => _onLogin(),
              ),
              SizedBox(height: AppNumbers.DOUBLE_32),
              SizedBox(
                width: double.infinity,
                height: AppNumbers.DOUBLE_52,
                child: ElevatedButton(
                  onPressed: (_controller.text.length == AppNumbers.INT_4 && !_isLoading) ? _onLogin : null,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    foregroundColor: AppColors.textOnPrimary,
                    disabledBackgroundColor: AppColors.primary.withValues(alpha: 0.5),
                    disabledForegroundColor: AppColors.textOnPrimary.withValues(alpha: 0.7),
                    elevation: AppNumbers.DOUBLE_0,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppNumbers.DOUBLE_16)),
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
                          AppStrings.loginPinButton,
                          style: textTheme.titleMedium?.copyWith(color: AppColors.textOnPrimary),
                        ),
                ),
              ),
              SizedBox(height: AppNumbers.DOUBLE_16),
              TextButton(
                onPressed: _onForgotPin,
                child: Text(AppStrings.loginPinForgotButton, style: textTheme.bodyMedium),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
