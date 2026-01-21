import 'package:flutter/material.dart';

import 'package:store_manage/core/constants/app_numbers.dart';
import 'package:store_manage/core/constants/app_strings.dart';
import 'package:store_manage/core/widgets/app_text_form_field.dart';
import 'package:store_manage/feature/stock_in/presentation/widgets/stock_in_validators.dart';

class StockInDateField extends StatelessWidget {
  final TextEditingController controller;
  final DateTime selectedDate;
  final ValueChanged<DateTime> onChanged;

  const StockInDateField({super.key, required this.controller, required this.selectedDate, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return AppTextFormField(
      controller: controller,
      readOnly: true,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      hintText: AppStrings.stockInDatePlaceholder,
      onTap: () => _selectDate(context),
      validator: (_) => StockInValidators.dateNotFuture(selectedDate),
    );
  }

  Future<void> _selectDate(BuildContext context) async {
    final today = DateTime.now();
    final picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(today.year - AppNumbers.INT_100, today.month, today.day),
      lastDate: DateTime(today.year, today.month, today.day),
    );
    if (picked != null) {
      onChanged(picked);
    }
  }
}
