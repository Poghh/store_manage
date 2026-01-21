import 'package:flutter/material.dart';

import 'package:store_manage/core/constants/app_colors.dart';
import 'package:store_manage/core/widgets/app_section_label.dart';

class RetailSectionLabel extends StatelessWidget {
  final String text;

  const RetailSectionLabel({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return AppSectionLabel(text: text, color: AppColors.textOnPrimary);
  }
}
