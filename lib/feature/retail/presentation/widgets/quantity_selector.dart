import 'package:flutter/material.dart';

import 'package:store_manage/core/constants/app_colors.dart';
import 'package:store_manage/core/constants/app_font_sizes.dart';
import 'package:store_manage/core/constants/app_fonts.dart';
import 'package:store_manage/core/constants/app_numbers.dart';
import 'package:store_manage/core/widgets/app_field_container.dart';

class QuantitySelector extends StatelessWidget {
  final int quantity;
  final VoidCallback onDecrease;
  final VoidCallback onIncrease;

  const QuantitySelector({super.key, required this.quantity, required this.onDecrease, required this.onIncrease});

  @override
  Widget build(BuildContext context) {
    return AppFieldContainer(
      padding: const EdgeInsets.symmetric(horizontal: AppNumbers.DOUBLE_12, vertical: AppNumbers.DOUBLE_6),
      child: Row(
        children: [
          _QtyButton(icon: Icons.remove, onTap: onDecrease),
          Expanded(
            child: Center(
              child: Text(
                quantity.toString(),
                style: const TextStyle(
                  fontSize: AppFontSizes.fontSize16,
                  fontWeight: FontWeight.w700,
                  fontFamily: AppFonts.inter,
                  color: AppColors.textPrimary,
                ),
              ),
            ),
          ),
          _QtyButton(icon: Icons.add, onTap: onIncrease),
        ],
      ),
    );
  }
}

class _QtyButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback? onTap;

  const _QtyButton({required this.icon, this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(AppNumbers.DOUBLE_8),
      child: Container(
        height: AppNumbers.DOUBLE_32,
        width: AppNumbers.DOUBLE_32,
        decoration: BoxDecoration(
          color: AppColors.primaryLight,
          borderRadius: BorderRadius.circular(AppNumbers.DOUBLE_8),
        ),
        child: Icon(icon, color: AppColors.primary, size: AppNumbers.DOUBLE_18),
      ),
    );
  }
}
