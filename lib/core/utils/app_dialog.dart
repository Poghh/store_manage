import 'package:flutter/material.dart';
import 'package:panara_dialogs/panara_dialogs.dart';

import 'package:store_manage/core/constants/app_colors.dart';
import 'package:store_manage/core/constants/app_font_sizes.dart';
import 'package:store_manage/core/constants/app_numbers.dart';

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
    PanaraDialogType type = PanaraDialogType.warning,
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

  static Color _resolveConfirmColor(PanaraDialogType type) {
    switch (type) {
      case PanaraDialogType.error:
        return AppColors.error;
      case PanaraDialogType.success:
        return AppColors.success;
      case PanaraDialogType.normal:
        return AppColors.primary;
      case PanaraDialogType.warning:
      default:
        return AppColors.warning;
    }
  }
}
