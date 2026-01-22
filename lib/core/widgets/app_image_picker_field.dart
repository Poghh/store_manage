import 'package:flutter/material.dart';

import 'package:store_manage/core/constants/app_numbers.dart';
import 'package:store_manage/core/constants/app_strings.dart';
import 'package:store_manage/core/widgets/app_product_thumbnail.dart';

class AppImagePickerField extends StatelessWidget {
  final String? image;
  final VoidCallback onPick;
  final VoidCallback onClear;

  const AppImagePickerField({super.key, required this.image, required this.onPick, required this.onClear});

  @override
  Widget build(BuildContext context) {
    final hasImage = image != null && image!.isNotEmpty;
    return Row(
      children: [
        AppProductThumbnail(
          imageUrl: image,
          size: AppNumbers.DOUBLE_80,
          borderRadius: AppNumbers.DOUBLE_12,
          padding: AppNumbers.DOUBLE_8,
          placeholderIcon: Icons.image_outlined,
        ),
        const SizedBox(width: AppNumbers.DOUBLE_12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              OutlinedButton.icon(
                onPressed: onPick,
                icon: const Icon(Icons.upload_outlined),
                label: const Text(AppStrings.stockInImagePickButton),
              ),
              if (hasImage) TextButton(onPressed: onClear, child: const Text(AppStrings.stockInImageRemoveButton)),
            ],
          ),
        ),
      ],
    );
  }
}
