import 'package:flutter/material.dart';
import 'package:panara_dialogs/panara_dialogs.dart';

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
    PanaraConfirmDialog.show(
      context,
      title: title,
      message: message,
      confirmButtonText: confirmText,
      cancelButtonText: cancelText,
      onTapConfirm: onConfirm,
      onTapCancel: onCancel,
      panaraDialogType: type,
      barrierDismissible: barrierDismissible,
    );
  }
}
