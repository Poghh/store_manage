import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:store_manage/core/constants/app_strings.dart';

class CommonFuntionUtils {
  static MaterialColor createMaterialColor(Color color) {
    List strengths = <double>[.05];
    Map<int, Color> swatch = {};
    final int r = (color.r * 255).round();
    final int g = (color.g * 255).round();
    final int b = (color.b * 255).round();

    for (int i = 1; i < 10; i++) {
      strengths.add(0.1 * i);
    }

    for (var strength in strengths) {
      final double ds = 0.5 - strength;
      swatch[(strength * 1000).round()] = Color.fromRGBO(
        r + ((ds < 0 ? r : (255 - r)) * ds).round(),
        g + ((ds < 0 ? g : (255 - g)) * ds).round(),
        b + ((ds < 0 ? b : (255 - b)) * ds).round(),
        1,
      );
    }

    return MaterialColor(color.toARGB32(), swatch);
  }

  static String formatCurrency(num value) {
    final formatter =
        NumberFormat.currency(locale: AppStrings.VIET_NAM_LOCALE, symbol: AppStrings.VIET_NAM_DONG_CURRENCY);
    return formatter.format(value);
  }

  static bool isValidEmail(String email) => RegExp(r"^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$").hasMatch(email);

  static bool isValidPhone(String phone) => RegExp(r'^(?:[+0]9)?[0-9]{10,11}$').hasMatch(phone);

  static String urlToMockFile(String url) {
    final uri = Uri.parse(url);
    final segments = uri.pathSegments;
    if (segments.isEmpty) return 'unknown';
    return segments.last;
  }
}
