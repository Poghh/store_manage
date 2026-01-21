import 'package:flutter/material.dart';

import 'package:store_manage/core/constants/app_colors.dart';
import 'package:store_manage/core/constants/app_numbers.dart';

class AppProductThumbnail extends StatelessWidget {
  final String? imageUrl;
  final double size;
  final double borderRadius;
  final double padding;
  final IconData placeholderIcon;
  final Color placeholderColor;
  final double placeholderSize;
  final Color backgroundColor;
  final BoxFit fit;

  const AppProductThumbnail({
    super.key,
    required this.imageUrl,
    required this.size,
    this.borderRadius = AppNumbers.DOUBLE_12,
    this.padding = AppNumbers.DOUBLE_6,
    this.placeholderIcon = Icons.inventory_2_outlined,
    this.placeholderColor = AppColors.primary,
    this.placeholderSize = AppNumbers.DOUBLE_28,
    this.backgroundColor = AppColors.background,
    this.fit = BoxFit.contain,
  });

  @override
  Widget build(BuildContext context) {
    final hasImage = imageUrl != null && imageUrl!.isNotEmpty;
    return ClipRRect(
      borderRadius: BorderRadius.circular(borderRadius),
      child: Container(
        width: size,
        height: size,
        color: backgroundColor,
        padding: EdgeInsets.all(padding),
        child: hasImage
            ? Image.network(imageUrl!, fit: fit)
            : Icon(placeholderIcon, color: placeholderColor, size: placeholderSize),
      ),
    );
  }
}
