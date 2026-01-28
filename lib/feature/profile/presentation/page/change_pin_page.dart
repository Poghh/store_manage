import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:store_manage/core/constants/app_colors.dart';
import 'package:store_manage/core/constants/app_numbers.dart';
import 'package:store_manage/core/constants/app_strings.dart';
import 'package:store_manage/core/DI/di.dart';
import 'package:store_manage/core/data/storage/secure_storage.dart';
import 'package:store_manage/core/utils/app_toast.dart';
import 'package:store_manage/core/widgets/app_input_decoration.dart';
import 'package:store_manage/core/widgets/app_section_label.dart';

class ChangePinPage extends StatefulWidget {
  const ChangePinPage({super.key});

  @override
  State<ChangePinPage> createState() => _ChangePinPageState();
}

class _ChangePinPageState extends State<ChangePinPage> {
  final _oldPinController = TextEditingController();
  final _newPinController = TextEditingController();
  final _confirmPinController = TextEditingController();
  final _oldPinFocusNode = FocusNode();
  final _newPinFocusNode = FocusNode();
  final _confirmPinFocusNode = FocusNode();
  bool _isLoading = false;
  String? _error;

  @override
  void dispose() {
    _oldPinController.dispose();
    _newPinController.dispose();
    _confirmPinController.dispose();
    _oldPinFocusNode.dispose();
    _newPinFocusNode.dispose();
    _confirmPinFocusNode.dispose();
    super.dispose();
  }

  bool get _isFormValid =>
      _oldPinController.text.length == AppNumbers.INT_4 &&
      _newPinController.text.length == AppNumbers.INT_4 &&
      _confirmPinController.text.length == AppNumbers.INT_4;

  String? _validateForm() {
    if (_oldPinController.text.length != AppNumbers.INT_4) {
      return AppStrings.changePinPinLength;
    }
    if (_newPinController.text.length != AppNumbers.INT_4) {
      return AppStrings.changePinPinLength;
    }
    if (_confirmPinController.text != _newPinController.text) {
      return AppStrings.changePinConfirmNotMatch;
    }
    return null;
  }

  Future<void> _handleChangePin() async {
    setState(() => _error = null);

    final validationError = _validateForm();
    if (validationError != null) {
      setState(() => _error = validationError);
      return;
    }

    setState(() => _isLoading = true);

    final storage = di<SecureStorageImpl>();
    final currentPin = await storage.getPin();

    if (_oldPinController.text != currentPin) {
      setState(() {
        _error = AppStrings.changePinOldPinIncorrect;
        _isLoading = false;
      });
      return;
    }

    await storage.savePin(_newPinController.text);

    setState(() => _isLoading = false);

    if (mounted) {
      AppToast.success(context, AppStrings.changePinSuccessMessage);
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text(AppStrings.changePinTitle),
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
              // Old PIN
              const AppSectionLabel(text: AppStrings.changePinOldPinLabel),
              const SizedBox(height: AppNumbers.DOUBLE_8),
              TextField(
                controller: _oldPinController,
                focusNode: _oldPinFocusNode,
                obscureText: true,
                keyboardType: TextInputType.number,
                maxLength: AppNumbers.INT_4,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                onChanged: (_) => setState(() => _error = null),
                onSubmitted: (_) => _newPinFocusNode.requestFocus(),
                decoration: AppInputDecoration.build(hintText: AppStrings.changePinOldPin, counterText: ''),
                style: textTheme.labelLarge?.copyWith(letterSpacing: 8),
              ),
              const SizedBox(height: AppNumbers.DOUBLE_16),

              // New PIN
              const AppSectionLabel(text: AppStrings.changePinNewPinLabel),
              const SizedBox(height: AppNumbers.DOUBLE_8),
              TextField(
                controller: _newPinController,
                focusNode: _newPinFocusNode,
                obscureText: true,
                keyboardType: TextInputType.number,
                maxLength: AppNumbers.INT_4,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                onChanged: (_) => setState(() => _error = null),
                onSubmitted: (_) => _confirmPinFocusNode.requestFocus(),
                decoration: AppInputDecoration.build(hintText: AppStrings.changePinNewPin, counterText: ''),
                style: textTheme.labelLarge?.copyWith(letterSpacing: 8),
              ),
              const SizedBox(height: AppNumbers.DOUBLE_16),

              // Confirm PIN
              const AppSectionLabel(text: AppStrings.changePinConfirmPinLabel),
              const SizedBox(height: AppNumbers.DOUBLE_8),
              TextField(
                controller: _confirmPinController,
                focusNode: _confirmPinFocusNode,
                obscureText: true,
                keyboardType: TextInputType.number,
                maxLength: AppNumbers.INT_4,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                onChanged: (_) => setState(() => _error = null),
                onSubmitted: (_) => _isFormValid ? _handleChangePin() : null,
                decoration: AppInputDecoration.build(hintText: AppStrings.changePinConfirmPin, counterText: ''),
                style: textTheme.labelLarge?.copyWith(letterSpacing: 8),
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
                        child: Text(_error!, style: textTheme.bodyMedium?.copyWith(color: AppColors.error)),
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
              onPressed: _isFormValid && !_isLoading ? _handleChangePin : null,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                foregroundColor: AppColors.textOnPrimary,
                disabledBackgroundColor: AppColors.primary.withValues(alpha: 0.5),
                disabledForegroundColor: AppColors.textOnPrimary.withValues(alpha: 0.7),
                elevation: AppNumbers.DOUBLE_0,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppNumbers.DOUBLE_12)),
              ),
              child: _isLoading
                  ? const SizedBox(
                      width: 20,
                      height: 20,
                      child: CircularProgressIndicator(strokeWidth: 2, color: AppColors.textOnPrimary),
                    )
                  : Text(AppStrings.changePinButton, style: textTheme.titleSmall?.copyWith(color: AppColors.textOnPrimary)),
            ),
          ),
        ),
      ),
    );
  }
}
