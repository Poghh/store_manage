import 'package:flutter/material.dart';

import 'package:store_manage/core/constants/app_colors.dart';
import 'package:store_manage/core/constants/app_font_sizes.dart';
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
      builder: (dialogContext) {
        final confirmColor = _resolveConfirmColor(type);
        return AlertDialog(
          insetPadding: const EdgeInsets.symmetric(horizontal: AppNumbers.DOUBLE_24, vertical: AppNumbers.DOUBLE_24),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppNumbers.DOUBLE_16)),
          title: Stack(
            children: [
              Align(
                alignment: Alignment.center,
                child: Padding(
                  padding: const EdgeInsets.only(top: AppNumbers.DOUBLE_6),
                  child: Text(
                    title,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: AppFontSizes.fontSize18,
                      fontWeight: FontWeight.w600,
                      color: AppColors.textPrimary,
                    ),
                  ),
                ),
              ),
              Positioned(
                top: -8,
                right: -8,
                child: IconButton(
                  constraints: const BoxConstraints(minWidth: AppNumbers.DOUBLE_32, minHeight: AppNumbers.DOUBLE_32),
                  padding: EdgeInsets.zero,
                  iconSize: AppNumbers.DOUBLE_20,
                  icon: const Icon(Icons.close, color: AppColors.textSecondary),
                  onPressed: () {
                    Navigator.of(dialogContext).pop();
                  },
                ),
              ),
            ],
          ),
          content: Text(
            message,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: AppFontSizes.fontSize14,
              color: AppColors.textSecondary,
              height: AppNumbers.DOUBLE_1_4,
            ),
          ),
          actionsPadding: const EdgeInsets.fromLTRB(
            AppNumbers.DOUBLE_16,
            AppNumbers.DOUBLE_0,
            AppNumbers.DOUBLE_16,
            AppNumbers.DOUBLE_16,
          ),
          actions: [
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () {
                      Navigator.of(dialogContext).pop();
                      onCancel();
                    },
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: AppNumbers.DOUBLE_12),
                      side: const BorderSide(color: AppColors.warning, width: AppNumbers.DOUBLE_1),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppNumbers.DOUBLE_10)),
                    ),
                    child: Text(
                      cancelText,
                      textAlign: TextAlign.center,
                      maxLines: AppNumbers.INT_2,
                      overflow: TextOverflow.visible,
                      style: const TextStyle(
                        fontSize: AppFontSizes.fontSize12,
                        fontWeight: FontWeight.w600,
                        color: AppColors.warning,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: AppNumbers.DOUBLE_12),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.of(dialogContext).pop();
                      onConfirm();
                    },
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: AppNumbers.DOUBLE_12),
                      backgroundColor: confirmColor,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppNumbers.DOUBLE_10)),
                    ),
                    child: Text(
                      confirmText,
                      textAlign: TextAlign.center,
                      maxLines: AppNumbers.INT_2,
                      overflow: TextOverflow.visible,
                      style: const TextStyle(
                        fontSize: AppFontSizes.fontSize12,
                        fontWeight: FontWeight.w600,
                        color: AppColors.textOnPrimary,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        );
      },
    );
  }

  /// Async version of confirm that returns true if confirmed, false otherwise
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
      builder: (dialogContext) {
        final confirmColor = _resolveConfirmColor(type);
        return AlertDialog(
          insetPadding: const EdgeInsets.symmetric(horizontal: AppNumbers.DOUBLE_24, vertical: AppNumbers.DOUBLE_24),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppNumbers.DOUBLE_16)),
          title: Stack(
            children: [
              Align(
                alignment: Alignment.center,
                child: Padding(
                  padding: const EdgeInsets.only(top: AppNumbers.DOUBLE_6),
                  child: Text(
                    title,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: AppFontSizes.fontSize18,
                      fontWeight: FontWeight.w600,
                      color: AppColors.textPrimary,
                    ),
                  ),
                ),
              ),
              Positioned(
                top: -8,
                right: -8,
                child: IconButton(
                  constraints: const BoxConstraints(minWidth: AppNumbers.DOUBLE_32, minHeight: AppNumbers.DOUBLE_32),
                  padding: EdgeInsets.zero,
                  iconSize: AppNumbers.DOUBLE_20,
                  icon: const Icon(Icons.close, color: AppColors.textSecondary),
                  onPressed: () => Navigator.of(dialogContext).pop(false),
                ),
              ),
            ],
          ),
          content: Text(
            message,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: AppFontSizes.fontSize14,
              color: AppColors.textSecondary,
              height: AppNumbers.DOUBLE_1_4,
            ),
          ),
          actionsPadding: const EdgeInsets.fromLTRB(
            AppNumbers.DOUBLE_16,
            AppNumbers.DOUBLE_0,
            AppNumbers.DOUBLE_16,
            AppNumbers.DOUBLE_16,
          ),
          actions: [
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () => Navigator.of(dialogContext).pop(false),
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: AppNumbers.DOUBLE_12),
                      side: BorderSide(color: confirmColor, width: AppNumbers.DOUBLE_1),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppNumbers.DOUBLE_10)),
                    ),
                    child: Text(
                      cancelText,
                      textAlign: TextAlign.center,
                      maxLines: AppNumbers.INT_2,
                      overflow: TextOverflow.visible,
                      style: TextStyle(
                        fontSize: AppFontSizes.fontSize12,
                        fontWeight: FontWeight.w600,
                        color: confirmColor,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: AppNumbers.DOUBLE_12),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () => Navigator.of(dialogContext).pop(true),
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: AppNumbers.DOUBLE_12),
                      backgroundColor: confirmColor,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppNumbers.DOUBLE_10)),
                    ),
                    child: Text(
                      confirmText,
                      textAlign: TextAlign.center,
                      maxLines: AppNumbers.INT_2,
                      overflow: TextOverflow.visible,
                      style: const TextStyle(
                        fontSize: AppFontSizes.fontSize12,
                        fontWeight: FontWeight.w600,
                        color: AppColors.textOnPrimary,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        );
      },
    );
    return result ?? false;
  }

  static Color _resolveConfirmColor(AppDialogType type) {
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
}
