import 'package:flutter/material.dart';

import 'package:store_manage/core/constants/app_colors.dart';
import 'package:store_manage/core/constants/app_numbers.dart';

enum AppDialogType { warning, error, success, normal }

class AppDialog {
  const AppDialog._();

  static void confirm({
    required BuildContext context,
    required String title,
    required String message,
    required String confirmText,
    required String cancelText,
    required VoidCallback onConfirm,
    required VoidCallback onCancel,
    AppDialogType type = AppDialogType.warning,
    bool barrierDismissible = true,
  }) {
    showDialog<void>(
      context: context,
      barrierDismissible: barrierDismissible,
      builder: (dialogContext) => _DialogContent(
        title: title,
        message: message,
        confirmText: confirmText,
        cancelText: cancelText,
        type: type,
        onConfirm: () {
          Navigator.of(dialogContext).pop();
          onConfirm();
        },
        onCancel: () {
          Navigator.of(dialogContext).pop();
          onCancel();
        },
        onClose: () => Navigator.of(dialogContext).pop(),
      ),
    );
  }

  static Future<bool> confirmAsync({
    required BuildContext context,
    required String title,
    required String message,
    required String confirmText,
    required String cancelText,
    AppDialogType type = AppDialogType.warning,
    bool barrierDismissible = true,
  }) async {
    final result = await showDialog<bool>(
      context: context,
      barrierDismissible: barrierDismissible,
      builder: (dialogContext) => _DialogContent(
        title: title,
        message: message,
        confirmText: confirmText,
        cancelText: cancelText,
        type: type,
        onConfirm: () => Navigator.of(dialogContext).pop(true),
        onCancel: () => Navigator.of(dialogContext).pop(false),
        onClose: () => Navigator.of(dialogContext).pop(false),
      ),
    );
    return result ?? false;
  }
}

class _DialogContent extends StatelessWidget {
  final String title;
  final String message;
  final String confirmText;
  final String cancelText;
  final AppDialogType type;
  final VoidCallback onConfirm;
  final VoidCallback onCancel;
  final VoidCallback onClose;

  const _DialogContent({
    required this.title,
    required this.message,
    required this.confirmText,
    required this.cancelText,
    required this.type,
    required this.onConfirm,
    required this.onCancel,
    required this.onClose,
  });

  Color get _typeColor {
    switch (type) {
      case AppDialogType.error:
        return AppColors.error;
      case AppDialogType.success:
        return AppColors.success;
      case AppDialogType.normal:
        return AppColors.primary;
      case AppDialogType.warning:
        return AppColors.warning;
    }
  }

  IconData get _typeIcon {
    switch (type) {
      case AppDialogType.error:
        return Icons.error_outline;
      case AppDialogType.success:
        return Icons.check_circle_outline;
      case AppDialogType.normal:
        return Icons.info_outline;
      case AppDialogType.warning:
        return Icons.warning_amber_rounded;
    }
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Dialog(
      insetPadding: const EdgeInsets.symmetric(horizontal: AppNumbers.DOUBLE_24),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppNumbers.DOUBLE_20),
      ),
      child: Padding(
        padding: const EdgeInsets.all(AppNumbers.DOUBLE_24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Icon
            Container(
              width: AppNumbers.DOUBLE_64,
              height: AppNumbers.DOUBLE_64,
              decoration: BoxDecoration(
                color: _typeColor.withValues(alpha: 0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(
                _typeIcon,
                size: AppNumbers.DOUBLE_32,
                color: _typeColor,
              ),
            ),
            const SizedBox(height: AppNumbers.DOUBLE_20),
            // Title
            Text(
              title,
              textAlign: TextAlign.center,
              style: textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w700),
            ),
            const SizedBox(height: AppNumbers.DOUBLE_12),
            // Message
            Text(
              message,
              textAlign: TextAlign.center,
              style: textTheme.bodyMedium?.copyWith(height: 1.5),
            ),
            const SizedBox(height: AppNumbers.DOUBLE_24),
            // Buttons
            Row(
              children: [
                Expanded(
                  child: SizedBox(
                    height: AppNumbers.DOUBLE_48,
                    child: OutlinedButton(
                      onPressed: onCancel,
                      style: OutlinedButton.styleFrom(
                        side: const BorderSide(color: AppColors.textSecondary, width: 1.5),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(AppNumbers.DOUBLE_12),
                        ),
                      ),
                      child: Text(cancelText, style: textTheme.titleSmall),
                    ),
                  ),
                ),
                const SizedBox(width: AppNumbers.DOUBLE_12),
                Expanded(
                  child: SizedBox(
                    height: AppNumbers.DOUBLE_48,
                    child: ElevatedButton(
                      onPressed: onConfirm,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: _typeColor,
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(AppNumbers.DOUBLE_12),
                        ),
                      ),
                      child: Text(confirmText, style: textTheme.titleSmall?.copyWith(color: AppColors.textOnPrimary)),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
