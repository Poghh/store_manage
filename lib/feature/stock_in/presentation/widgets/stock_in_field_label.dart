import 'package:flutter/material.dart';

import 'package:store_manage/core/constants/app_colors.dart';
import 'package:store_manage/core/widgets/app_section_label.dart';

class StockInFieldLabel extends StatelessWidget {
  final String text;

  const StockInFieldLabel({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return AppSectionLabel(text: text, color: AppColors.textSecondary);
  }
}
