import 'package:flutter/material.dart';

import 'package:store_manage/core/constants/app_colors.dart';
import 'package:store_manage/core/constants/app_strings.dart';
import 'package:store_manage/core/widgets/app_action_button.dart';

class ConfirmButton extends StatelessWidget {
  final VoidCallback? onPressed;

  const ConfirmButton({super.key, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return AppActionButton(
      onPressed: onPressed,
      label: AppStrings.retailConfirmButton,
      backgroundColor: AppColors.primaryDark,
    );
  }
}
