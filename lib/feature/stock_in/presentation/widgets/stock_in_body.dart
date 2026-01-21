import 'package:flutter/material.dart';

import 'package:store_manage/core/constants/app_numbers.dart';
import 'package:store_manage/core/widgets/app_surface_card.dart';
import 'package:store_manage/feature/stock_in/presentation/widgets/stock_in_form.dart';
import 'package:store_manage/feature/stock_in/presentation/widgets/stock_in_form_controller.dart';

class StockInBody extends StatelessWidget {
  final StockInFormController formController;

  const StockInBody({super.key, required this.formController});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppNumbers.DOUBLE_16, vertical: AppNumbers.DOUBLE_8),
            child: AppSurfaceCard(
              padding: EdgeInsets.zero,
              child: StockInForm(controller: formController),
            ),
          ),
        ),
      ],
    );
  }
}
