import 'package:flutter/material.dart';

import 'package:store_manage/core/constants/app_colors.dart';
import 'package:store_manage/core/widgets/app_input_decoration.dart';

class StockInDropdownField extends StatelessWidget {
  final List<String> items;
  final String? value;
  final String? Function(String?)? validator;
  final ValueChanged<String?>? onChanged;

  const StockInDropdownField({super.key, required this.items, required this.value, this.validator, this.onChanged});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return DropdownButtonFormField<String>(
      initialValue: value,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      icon: const Icon(Icons.expand_more, color: AppColors.textSecondary),
      validator: validator,
      decoration: AppInputDecoration.build(hintText: ''),
      items: items
          .map(
            (item) => DropdownMenuItem<String>(
              value: item,
              child: Text(item, style: textTheme.labelLarge),
            ),
          )
          .toList(),
      onChanged: onChanged,
    );
  }
}
