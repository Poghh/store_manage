import 'package:flutter/material.dart';
import 'package:store_manage/core/constants/app_numbers.dart';
import 'package:toastification/toastification.dart';

class AppToast {
  const AppToast._();

  /// Check if Navigator is available in context
  static bool _isNavigatorReady(BuildContext context) {
    return Navigator.maybeOf(context) != null;
  }

  static void success(BuildContext context, String message) {
    if (!_isNavigatorReady(context)) return;
    toastification.show(
      context: context,
      type: ToastificationType.success,
      title: Text(message),
      autoCloseDuration: Duration(seconds: AppNumbers.INT_3),
    );
  }

  static void warning(BuildContext context, String message) {
    if (!_isNavigatorReady(context)) return;
    toastification.show(
      context: context,
      type: ToastificationType.warning,
      title: Text(message),
      autoCloseDuration: Duration(seconds: AppNumbers.INT_3),
    );
  }

  static void error(BuildContext context, String message) {
    if (!_isNavigatorReady(context)) return;
    toastification.show(
      context: context,
      type: ToastificationType.error,
      title: Text(message),
      autoCloseDuration: Duration(seconds: AppNumbers.INT_3),
    );
  }
}
