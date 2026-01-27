import 'package:flutter/material.dart';

import 'package:store_manage/core/constants/app_numbers.dart';
import 'package:store_manage/feature/stock_in/presentation/widgets/stock_in_form.dart';
import 'package:store_manage/feature/stock_in/presentation/widgets/stock_in_form_controller.dart';

class StockInBody extends StatelessWidget {
  final StockInFormController formController;

  const StockInBody({super.key, required this.formController});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: AppNumbers.DOUBLE_16),
      child: StockInForm(controller: formController),
    );
  }
}
