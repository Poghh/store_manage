import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:store_manage/core/DI/di.dart';
import 'package:store_manage/core/constants/app_colors.dart';
import 'package:store_manage/core/constants/app_font_sizes.dart';
import 'package:store_manage/core/constants/app_fonts.dart';
import 'package:store_manage/core/constants/app_numbers.dart';
import 'package:store_manage/core/constants/app_strings.dart';
import 'package:store_manage/core/navigation/app_router.dart';
import 'package:store_manage/core/storage/secure_storage.dart';
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
    if (!_isFormValid) return;

    final secureStorage = di<SecureStorageImpl>();
    await secureStorage.saveUserName(_nameController.text.trim());
    await secureStorage.saveStoreName(_storeController.text.trim());

    if (mounted) {
      context.router.replaceAll([const HomeTabsRoute()]);
    }
  }

  @override
  Widget build(BuildContext context) {
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
              const Text(
                AppStrings.setupProfileTitle,
                style: TextStyle(
                  fontSize: AppFontSizes.fontSize24,
                  fontWeight: FontWeight.w700,
                  fontFamily: AppFonts.inter,
                  color: AppColors.textPrimary,
                ),
              ),
              const SizedBox(height: AppNumbers.DOUBLE_8),
              const Text(
                AppStrings.setupProfileSubtitle,
                style: TextStyle(
                  fontSize: AppFontSizes.fontSize14,
                  fontFamily: AppFonts.inter,
                  color: AppColors.textSecondary,
                ),
              ),
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
                style: const TextStyle(
                  fontSize: AppFontSizes.fontSize14,
                  fontWeight: FontWeight.w500,
                  fontFamily: AppFonts.inter,
                  color: AppColors.textPrimary,
                ),
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
                style: const TextStyle(
                  fontSize: AppFontSizes.fontSize14,
                  fontWeight: FontWeight.w500,
                  fontFamily: AppFonts.inter,
                  color: AppColors.textPrimary,
                ),
              ),
              const SizedBox(height: AppNumbers.DOUBLE_24),
              SizedBox(
                width: double.infinity,
                height: AppNumbers.DOUBLE_48,
                child: ElevatedButton(
                  onPressed: _isFormValid ? _onComplete : null,
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
                  child: const Text(
                    AppStrings.setupProfileButton,
                    style: TextStyle(
                      fontSize: AppFontSizes.fontSize14,
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
