import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:store_manage/core/constants/app_numbers.dart';
import 'package:store_manage/core/constants/app_strings.dart';
import 'package:store_manage/feature/stock_in/presentation/widgets/stock_in_date_field.dart';
import 'package:store_manage/feature/stock_in/presentation/widgets/stock_in_dropdown_field.dart';
import 'package:store_manage/feature/stock_in/presentation/widgets/stock_in_currency_input_formatter.dart';
import 'package:store_manage/feature/stock_in/presentation/widgets/stock_in_field_label.dart';
import 'package:store_manage/feature/stock_in/presentation/widgets/stock_in_form_controller.dart';
import 'package:store_manage/feature/stock_in/presentation/widgets/stock_in_search_bar.dart';
import 'package:store_manage/core/widgets/app_text_form_field.dart';
import 'package:store_manage/feature/stock_in/presentation/widgets/stock_in_validators.dart';

class StockInForm extends StatefulWidget {
  final StockInFormController controller;

  const StockInForm({super.key, required this.controller});

  @override
  State<StockInForm> createState() => _StockInFormState();
}

class _StockInFormState extends State<StockInForm> {
  bool _suppressNameChange = false;

  static const List<String> _categories = [
    AppStrings.stockInCategoryDevice,
    AppStrings.stockInCategoryAccessory,
    AppStrings.stockInCategoryService,
    AppStrings.stockInCategoryOther,
  ];

  static const List<String> _platforms = [
    AppStrings.stockInPlatformAndroid,
    AppStrings.stockInPlatformIos,
    AppStrings.stockInPlatformNone,
  ];

  static const List<String> _brands = [
    AppStrings.stockInBrandApple,
    AppStrings.stockInBrandSamsung,
    AppStrings.stockInBrandXiaomi,
    AppStrings.stockInBrandOppo,
    AppStrings.stockInBrandNone,
  ];

  static const List<String> _units = [
    AppStrings.stockInUnitPiece,
    AppStrings.stockInUnitBox,
    AppStrings.stockInUnitSet,
    AppStrings.stockInUnitKg,
  ];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(
        AppNumbers.DOUBLE_16,
        AppNumbers.DOUBLE_16,
        AppNumbers.DOUBLE_16,
        AppNumbers.DOUBLE_16,
      ),
      child: Form(
        key: widget.controller.formKey,
        autovalidateMode: AutovalidateMode.disabled,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            StockInFieldLabel(text: AppStrings.stockInProductNameLabel),
            const SizedBox(height: AppNumbers.DOUBLE_8),
            StockInSearchBar(
              controller: widget.controller.productNameController,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              validator: StockInValidators.requiredField,
              onChanged: (value) {
                if (_suppressNameChange) {
                  _suppressNameChange = false;
                  return;
                }
                setState(() {
                  widget.controller.resetSelectionForNewProduct();
                });
              },
              onSelected: (item) {
                setState(() {
                  _suppressNameChange = true;
                  widget.controller.applyPrefill(
                    productCode: item.productCode,
                    productName: item.productName,
                    category: item.category,
                    platform: item.platform,
                    brand: item.brand,
                    unit: item.unit,
                    quantity: item.quantity,
                    purchasePrice: item.purchasePrice,
                    stockInDate: item.stockInDate,
                  );
                });
              },
            ),
            const SizedBox(height: AppNumbers.DOUBLE_16),
            StockInFieldLabel(text: AppStrings.stockInProductCodeLabel),
            const SizedBox(height: AppNumbers.DOUBLE_8),
            AppTextFormField(
              enabled: false,
              controller: widget.controller.productCodeController,
              hintText: widget.controller.productCode,
            ),
            const SizedBox(height: AppNumbers.DOUBLE_16),
            StockInFieldLabel(text: AppStrings.stockInCategoryLabel),
            const SizedBox(height: AppNumbers.DOUBLE_8),
            StockInDropdownField(
              items: _categories,
              value: _categories.contains(widget.controller.category) ? widget.controller.category : null,
              validator: StockInValidators.requiredField,
              onChanged: (value) => setState(() => widget.controller.category = value),
            ),
            const SizedBox(height: AppNumbers.DOUBLE_16),
            StockInFieldLabel(text: AppStrings.stockInPlatformLabel),
            const SizedBox(height: AppNumbers.DOUBLE_8),
            StockInDropdownField(
              items: _platforms,
              value: _platforms.contains(widget.controller.platform) ? widget.controller.platform : null,
              onChanged: (value) => setState(() => widget.controller.platform = value),
            ),
            const SizedBox(height: AppNumbers.DOUBLE_16),
            StockInFieldLabel(text: AppStrings.stockInBrandLabel),
            const SizedBox(height: AppNumbers.DOUBLE_8),
            StockInDropdownField(
              items: _brands,
              value: _brands.contains(widget.controller.brand) ? widget.controller.brand : null,
              onChanged: (value) => setState(() => widget.controller.brand = value),
            ),
            const SizedBox(height: AppNumbers.DOUBLE_16),
            StockInFieldLabel(text: AppStrings.stockInUnitLabel),
            const SizedBox(height: AppNumbers.DOUBLE_8),
            StockInDropdownField(
              items: _units,
              value: _units.contains(widget.controller.unit) ? widget.controller.unit : null,
              validator: StockInValidators.requiredField,
              onChanged: (value) => setState(() => widget.controller.unit = value),
            ),
            const SizedBox(height: AppNumbers.DOUBLE_16),
            StockInFieldLabel(text: AppStrings.stockInQuantityLabel),
            const SizedBox(height: AppNumbers.DOUBLE_8),
            AppTextFormField(
              controller: widget.controller.quantityController,
              keyboardType: TextInputType.number,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              hintText: AppStrings.stockInQuantityHint,
              validator: StockInValidators.positiveInt,
            ),
            const SizedBox(height: AppNumbers.DOUBLE_16),
            StockInFieldLabel(text: AppStrings.stockInPurchasePriceLabel),
            const SizedBox(height: AppNumbers.DOUBLE_8),
            AppTextFormField(
              controller: widget.controller.priceController,
              keyboardType: TextInputType.number,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly, StockInCurrencyInputFormatter()],
              hintText: AppStrings.stockInPriceHint,
              validator: StockInValidators.positiveNumber,
            ),
            const SizedBox(height: AppNumbers.DOUBLE_16),
            StockInFieldLabel(text: AppStrings.stockInDateLabel),
            const SizedBox(height: AppNumbers.DOUBLE_8),
            StockInDateField(
              controller: widget.controller.dateController,
              selectedDate: widget.controller.selectedDate,
              onChanged: (value) {
                setState(() {
                  widget.controller.updateDate(value);
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}
