import 'dart:io';

import 'package:flutter/material.dart';
import 'package:store_manage/core/DI/di.dart';
import 'package:store_manage/core/constants/app_colors.dart';
import 'package:store_manage/core/constants/app_font_sizes.dart';
import 'package:store_manage/core/constants/app_fonts.dart';
import 'package:store_manage/core/constants/app_numbers.dart';
import 'package:store_manage/core/constants/app_strings.dart';
import 'package:store_manage/core/storage/secure_storage.dart';
import 'package:store_manage/core/utils/app_image_picker.dart';
import 'package:store_manage/core/utils/app_toast.dart';
import 'package:store_manage/core/widgets/app_input_decoration.dart';
import 'package:store_manage/core/widgets/app_section_label.dart';

class EditProfilePage extends StatefulWidget {
  final String initialName;
  final String initialStoreName;
  final String? initialAvatarPath;

  const EditProfilePage({
    super.key,
    required this.initialName,
    required this.initialStoreName,
    this.initialAvatarPath,
  });

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  late final TextEditingController _nameController;
  late final TextEditingController _storeController;
  final _nameFocusNode = FocusNode();
  final _storeFocusNode = FocusNode();
  bool _isLoading = false;
  String? _error;
  String? _avatarPath;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.initialName);
    _storeController = TextEditingController(text: widget.initialStoreName);
    _avatarPath = widget.initialAvatarPath;
  }

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

  bool get _hasChanges =>
      _nameController.text.trim() != widget.initialName ||
      _storeController.text.trim() != widget.initialStoreName ||
      _avatarPath != widget.initialAvatarPath;

  String? _validateForm() {
    if (_nameController.text.trim().isEmpty) {
      return AppStrings.setupProfileNameRequired;
    }
    if (_storeController.text.trim().isEmpty) {
      return AppStrings.setupProfileStoreRequired;
    }
    return null;
  }

  Future<void> _onSave() async {
    setState(() => _error = null);

    final validationError = _validateForm();
    if (validationError != null) {
      setState(() => _error = validationError);
      return;
    }

    if (!_hasChanges) return;

    setState(() => _isLoading = true);

    final storage = di<SecureStorageImpl>();
    await storage.saveUserName(_nameController.text.trim());
    await storage.saveStoreName(_storeController.text.trim());
    if (_avatarPath != null && _avatarPath!.isNotEmpty) {
      await storage.saveAvatarPath(_avatarPath!);
    } else {
      await storage.clearAvatarPath();
    }

    setState(() => _isLoading = false);

    if (mounted) {
      AppToast.success(context, AppStrings.editProfileSaveSuccess);
      Navigator.of(context).pop(true);
    }
  }

  Future<void> _handlePickAvatar() async {
    final path = await AppImagePicker.pickImage(context);
    if (path == null || path.isEmpty) return;
    setState(() {
      _avatarPath = path;
    });
  }

  void _handleRemoveAvatar() {
    setState(() {
      _avatarPath = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(AppStrings.editProfileTitle),
        backgroundColor: AppColors.primary,
        foregroundColor: AppColors.textOnPrimary,
      ),
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(AppNumbers.DOUBLE_16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Avatar Section
              const AppSectionLabel(text: AppStrings.editProfileAvatarLabel),
              const SizedBox(height: AppNumbers.DOUBLE_12),
              _buildAvatarSection(),
              const SizedBox(height: AppNumbers.DOUBLE_24),

              // Name Field
              const AppSectionLabel(text: AppStrings.editProfileNameLabel),
              const SizedBox(height: AppNumbers.DOUBLE_8),
              TextField(
                controller: _nameController,
                focusNode: _nameFocusNode,
                textCapitalization: TextCapitalization.words,
                onChanged: (_) => setState(() => _error = null),
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

              // Store Name Field
              const AppSectionLabel(text: AppStrings.editProfileStoreLabel),
              const SizedBox(height: AppNumbers.DOUBLE_8),
              TextField(
                controller: _storeController,
                focusNode: _storeFocusNode,
                textCapitalization: TextCapitalization.words,
                onChanged: (_) => setState(() => _error = null),
                onSubmitted: (_) => _isFormValid && _hasChanges ? _onSave() : null,
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

              // Error Box
              if (_error != null) ...[
                const SizedBox(height: AppNumbers.DOUBLE_16),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(AppNumbers.DOUBLE_12),
                  decoration: BoxDecoration(
                    color: AppColors.error.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(AppNumbers.DOUBLE_12),
                  ),
                  child: Row(
                    children: [
                      const Icon(Icons.error_outline, color: AppColors.error, size: AppNumbers.DOUBLE_20),
                      const SizedBox(width: AppNumbers.DOUBLE_8),
                      Expanded(
                        child: Text(
                          _error!,
                          style: const TextStyle(
                            fontSize: AppFontSizes.fontSize14,
                            fontFamily: AppFonts.inter,
                            color: AppColors.error,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(AppNumbers.DOUBLE_16),
          child: SizedBox(
            width: double.infinity,
            height: AppNumbers.DOUBLE_48,
            child: ElevatedButton(
              onPressed: _isFormValid && _hasChanges && !_isLoading ? _onSave : null,
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
                      width: 20,
                      height: 20,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        color: AppColors.textOnPrimary,
                      ),
                    )
                  : const Text(
                      AppStrings.editProfileSaveButton,
                      style: TextStyle(
                        fontSize: AppFontSizes.fontSize14,
                        fontWeight: FontWeight.w600,
                        fontFamily: AppFonts.inter,
                      ),
                    ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildAvatarSection() {
    final hasAvatar = _avatarPath != null && _avatarPath!.isNotEmpty;

    return Center(
      child: Column(
        children: [
          // Avatar Circle
          Container(
            width: AppNumbers.DOUBLE_100,
            height: AppNumbers.DOUBLE_100,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: AppColors.surfaceMuted,
              border: Border.all(color: AppColors.border, width: 2),
            ),
            child: ClipOval(
              child: hasAvatar
                  ? Image.file(
                      File(_avatarPath!),
                      fit: BoxFit.cover,
                      width: AppNumbers.DOUBLE_100,
                      height: AppNumbers.DOUBLE_100,
                      errorBuilder: (context, error, stackTrace) => _buildAvatarPlaceholder(),
                    )
                  : _buildAvatarPlaceholder(),
            ),
          ),
          const SizedBox(height: AppNumbers.DOUBLE_12),

          // Action Buttons
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              OutlinedButton.icon(
                onPressed: _handlePickAvatar,
                icon: const Icon(Icons.camera_alt_outlined, size: AppNumbers.DOUBLE_18),
                label: Text(hasAvatar ? AppStrings.editProfileAvatarChangeButton : AppStrings.stockInImagePickButton),
                style: OutlinedButton.styleFrom(
                  foregroundColor: AppColors.primary,
                  side: const BorderSide(color: AppColors.primary),
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppNumbers.DOUBLE_16,
                    vertical: AppNumbers.DOUBLE_8,
                  ),
                ),
              ),
              if (hasAvatar) ...[
                const SizedBox(width: AppNumbers.DOUBLE_12),
                TextButton(
                  onPressed: _handleRemoveAvatar,
                  child: const Text(
                    AppStrings.editProfileAvatarRemoveButton,
                    style: TextStyle(color: AppColors.error),
                  ),
                ),
              ],
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildAvatarPlaceholder() {
    return Container(
      color: AppColors.surfaceMuted,
      child: const Icon(
        Icons.person_outline,
        size: AppNumbers.DOUBLE_48,
        color: AppColors.textMuted,
      ),
    );
  }
}
