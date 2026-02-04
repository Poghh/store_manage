import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:store_manage/core/DI/di.dart';
import 'package:store_manage/core/constants/app_colors.dart';
import 'package:store_manage/core/constants/app_numbers.dart';
import 'package:store_manage/core/constants/app_strings.dart';
import 'package:store_manage/core/data/services/auth_token_service.dart';
import 'package:store_manage/core/navigation/app_router.dart';
import 'package:store_manage/core/data/storage/secure_storage.dart';
import 'package:store_manage/core/widgets/app_input_decoration.dart';

@RoutePage()
class SetupProfilePage extends StatefulWidget {
  const SetupProfilePage({super.key});

  @override
  State<SetupProfilePage> createState() => _SetupProfilePageState();
}

class _SetupProfilePageState extends State<SetupProfilePage> {
  final _nameController = TextEditingController();
  final _storeController = TextEditingController();
  final _nameFocusNode = FocusNode();
  final _storeFocusNode = FocusNode();
  bool _isLoading = false;

  @override
  void dispose() {
    _nameController.dispose();
    _storeController.dispose();
    _nameFocusNode.dispose();
    _storeFocusNode.dispose();
    super.dispose();
  }

  bool get _isFormValid =>
      _nameController.text.trim().isNotEmpty && _storeController.text.trim().isNotEmpty;

  Future<void> _onComplete() async {
    if (!_isFormValid || _isLoading) return;

    setState(() => _isLoading = true);

    final secureStorage = di<SecureStorageImpl>();
    final userName = _nameController.text.trim();
    final storeName = _storeController.text.trim();

    // Lấy phone đã lưu từ PinInputPage
    final phone = await secureStorage.getSavedPhoneNumber();
    if (phone == null || phone.isEmpty) {
      if (mounted) {
        setState(() => _isLoading = false);
      }
      return;
    }

    // Tạo credentials và lấy token từ server
    await di<AuthTokenService>().createCredentialsAndGetToken(
      phone: phone,
      storeName: storeName,
      userName: userName,
    );

    // Lưu thông tin local
    await secureStorage.saveUserName(userName);
    await secureStorage.saveStoreName(storeName);

    if (mounted) {
      context.router.replaceAll([const HomeTabsRoute()]);
    }
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppNumbers.DOUBLE_24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.person_outline,
                size: AppNumbers.DOUBLE_64,
                color: AppColors.primary,
              ),
              const SizedBox(height: AppNumbers.DOUBLE_24),
              Text(AppStrings.setupProfileTitle, style: textTheme.displayMedium),
              const SizedBox(height: AppNumbers.DOUBLE_8),
              Text(AppStrings.setupProfileSubtitle, style: textTheme.bodyMedium),
              const SizedBox(height: AppNumbers.DOUBLE_32),
              TextField(
                controller: _nameController,
                focusNode: _nameFocusNode,
                textCapitalization: TextCapitalization.words,
                onChanged: (_) => setState(() {}),
                onSubmitted: (_) => _storeFocusNode.requestFocus(),
                decoration: AppInputDecoration.build(
                  hintText: AppStrings.setupProfileNameHint,
                ),
                style: textTheme.labelLarge?.copyWith(color: AppColors.textPrimary),
              ),
              const SizedBox(height: AppNumbers.DOUBLE_16),
              TextField(
                controller: _storeController,
                focusNode: _storeFocusNode,
                textCapitalization: TextCapitalization.words,
                onChanged: (_) => setState(() {}),
                onSubmitted: (_) => _isFormValid ? _onComplete() : null,
                decoration: AppInputDecoration.build(
                  hintText: AppStrings.setupProfileStoreHint,
                ),
                style: textTheme.labelLarge?.copyWith(color: AppColors.textPrimary),
              ),
              const SizedBox(height: AppNumbers.DOUBLE_24),
              SizedBox(
                width: double.infinity,
                height: AppNumbers.DOUBLE_48,
                child: ElevatedButton(
                  onPressed: (_isFormValid && !_isLoading) ? _onComplete : null,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    foregroundColor: AppColors.textOnPrimary,
                    disabledBackgroundColor: AppColors.primary.withValues(alpha: 0.5),
                    disabledForegroundColor: AppColors.textOnPrimary.withValues(alpha: 0.7),
                    elevation: AppNumbers.DOUBLE_0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(AppNumbers.DOUBLE_12),
                    ),
                  ),
                  child: _isLoading
                      ? const SizedBox(
                          width: AppNumbers.DOUBLE_20,
                          height: AppNumbers.DOUBLE_20,
                          child: CircularProgressIndicator(
                            strokeWidth: AppNumbers.DOUBLE_2,
                            color: AppColors.textOnPrimary,
                          ),
                        )
                      : Text(AppStrings.setupProfileButton, style: textTheme.titleSmall?.copyWith(color: AppColors.textOnPrimary)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
