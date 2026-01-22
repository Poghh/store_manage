import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:store_manage/core/utils/app_toast.dart';

import 'package:store_manage/core/DI/di.dart';
import 'package:store_manage/core/constants/app_colors.dart';
import 'package:store_manage/core/constants/app_font_sizes.dart';
import 'package:store_manage/core/constants/app_numbers.dart';
import 'package:store_manage/core/constants/app_strings.dart';
import 'package:store_manage/core/services/inventory_adjustment_service.dart';
import 'package:store_manage/core/services/local_product_service.dart';
import 'package:store_manage/core/utils/app_image_picker.dart';
import 'package:store_manage/core/widgets/app_action_button.dart';
import 'package:store_manage/core/widgets/app_product_thumbnail.dart';
import 'package:store_manage/core/widgets/app_surface_card.dart';
import 'package:store_manage/core/widgets/app_text_form_field.dart';
import 'package:store_manage/feature/stock_in/presentation/widgets/stock_in_date_field.dart';
import 'package:store_manage/feature/stock_in/presentation/widgets/stock_in_dropdown_field.dart';
import 'package:store_manage/feature/stock_in/presentation/widgets/stock_in_currency_input_formatter.dart';
import 'package:store_manage/feature/stock_in/presentation/widgets/stock_in_field_label.dart';
import 'package:store_manage/feature/stock_in/presentation/widgets/stock_in_validators.dart';

class ProductEditPage extends StatefulWidget {
  final String productCode;
  final String productName;
  final String category;
  final String platform;
  final String brand;
  final String unit;
  final String purchasePrice;
  final String stockInDate;
  final String? imageUrl;
  final int baseQuantity;
  final int initialAdjustment;

  const ProductEditPage({
    super.key,
    required this.productCode,
    required this.productName,
    required this.category,
    required this.platform,
    required this.brand,
    required this.unit,
    required this.purchasePrice,
    required this.stockInDate,
    required this.imageUrl,
    required this.baseQuantity,
    required this.initialAdjustment,
  });

  @override
  State<ProductEditPage> createState() => _ProductEditPageState();
}

class _ProductEditPageState extends State<ProductEditPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late final TextEditingController _nameController;
  late final TextEditingController _priceController;
  late final TextEditingController _dateController;
  late final TextEditingController _quantityController;
  String? _imagePath;
  String? _imageUrl;
  String? _category;
  String? _platform;
  String? _brand;
  String? _unit;
  final NumberFormat _priceFormat = NumberFormat.decimalPattern(AppStrings.VIET_NAM_LOCALE);

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
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.productName);
    _priceController = TextEditingController(text: widget.purchasePrice);
    _dateController = TextEditingController(text: widget.stockInDate);
    _quantityController = TextEditingController(text: widget.baseQuantity.toString());
    _imageUrl = widget.imageUrl;
    _category = widget.category.isEmpty ? null : widget.category;
    _platform = widget.platform.isEmpty ? null : widget.platform;
    _brand = widget.brand.isEmpty ? null : widget.brand;
    _unit = widget.unit.isEmpty ? null : widget.unit;
  }

  @override
  void dispose() {
    _nameController.dispose();
    _priceController.dispose();
    _dateController.dispose();
    _quantityController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: AppNumbers.DOUBLE_0,
        scrolledUnderElevation: AppNumbers.DOUBLE_0,
        surfaceTintColor: AppColors.background,
        leading: IconButton(
          onPressed: () => Navigator.of(context).maybePop(),
          icon: const Icon(Icons.arrow_back, color: AppColors.textPrimary),
        ),
        title: const Text(
          AppStrings.productEditTitle,
          style: TextStyle(
            fontSize: AppFontSizes.fontSize18,
            fontWeight: FontWeight.w600,
            color: AppColors.textPrimary,
          ),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(AppNumbers.DOUBLE_16),
          child: AppSurfaceCard(
            padding: EdgeInsets.zero,
            child: Form(
              key: _formKey,
              child: ListView(
                padding: const EdgeInsets.all(AppNumbers.DOUBLE_16),
                children: [
                  StockInFieldLabel(text: AppStrings.stockInProductCodeLabel),
                  const SizedBox(height: AppNumbers.DOUBLE_8),
                  AppTextFormField(enabled: false, initialValue: widget.productCode),
                  const SizedBox(height: AppNumbers.DOUBLE_16),
                  StockInFieldLabel(text: AppStrings.stockInImageLabel),
                  const SizedBox(height: AppNumbers.DOUBLE_8),
                  _ProductEditImagePicker(
                    image: _imagePath ?? _imageUrl,
                    onPick: _handlePickImage,
                    onClear: _handleClearImage,
                  ),
                  const SizedBox(height: AppNumbers.DOUBLE_16),
                  StockInFieldLabel(text: AppStrings.stockInProductNameLabel),
                  const SizedBox(height: AppNumbers.DOUBLE_8),
                  AppTextFormField(
                    controller: _nameController,
                    hintText: AppStrings.stockInProductNameHint,
                    validator: StockInValidators.requiredField,
                  ),
                  const SizedBox(height: AppNumbers.DOUBLE_16),
                  StockInFieldLabel(text: AppStrings.stockInCategoryLabel),
                  const SizedBox(height: AppNumbers.DOUBLE_8),
                  StockInDropdownField(
                    items: _categories,
                    value: _categories.contains(_category) ? _category : null,
                    validator: StockInValidators.requiredField,
                    onChanged: (value) => setState(() => _category = value),
                  ),
                  const SizedBox(height: AppNumbers.DOUBLE_16),
                  StockInFieldLabel(text: AppStrings.stockInPlatformLabel),
                  const SizedBox(height: AppNumbers.DOUBLE_8),
                  StockInDropdownField(
                    items: _platforms,
                    value: _platforms.contains(_platform) ? _platform : null,
                    onChanged: (value) => setState(() => _platform = value),
                  ),
                  const SizedBox(height: AppNumbers.DOUBLE_16),
                  StockInFieldLabel(text: AppStrings.stockInBrandLabel),
                  const SizedBox(height: AppNumbers.DOUBLE_8),
                  StockInDropdownField(
                    items: _brands,
                    value: _brands.contains(_brand) ? _brand : null,
                    onChanged: (value) => setState(() => _brand = value),
                  ),
                  const SizedBox(height: AppNumbers.DOUBLE_16),
                  StockInFieldLabel(text: AppStrings.stockInUnitLabel),
                  const SizedBox(height: AppNumbers.DOUBLE_8),
                  StockInDropdownField(
                    items: _units,
                    value: _units.contains(_unit) ? _unit : null,
                    validator: StockInValidators.requiredField,
                    onChanged: (value) => setState(() => _unit = value),
                  ),
                  const SizedBox(height: AppNumbers.DOUBLE_16),
                  StockInFieldLabel(text: AppStrings.stockInQuantityLabel),
                  const SizedBox(height: AppNumbers.DOUBLE_8),
                  AppTextFormField(
                    controller: _quantityController,
                    keyboardType: TextInputType.number,
                    hintText: AppStrings.stockInQuantityHint,
                    validator: _nonNegativeInt,
                  ),
                  const SizedBox(height: AppNumbers.DOUBLE_16),
                  StockInFieldLabel(text: AppStrings.stockInPurchasePriceLabel),
                  const SizedBox(height: AppNumbers.DOUBLE_8),
                  AppTextFormField(
                    controller: _priceController,
                    keyboardType: TextInputType.number,
                    hintText: AppStrings.stockInPriceHint,
                    inputFormatters: [StockInCurrencyInputFormatter(numberFormat: _priceFormat)],
                    validator: StockInValidators.positiveNumber,
                  ),
                  const SizedBox(height: AppNumbers.DOUBLE_16),
                  StockInFieldLabel(text: AppStrings.stockInDateLabel),
                  const SizedBox(height: AppNumbers.DOUBLE_8),
                  StockInDateField(
                    controller: _dateController,
                    selectedDate: _tryParseDate(_dateController.text) ?? DateTime.now(),
                    onChanged: (value) => setState(() => _dateController.text = _formatDate(value)),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(
            AppNumbers.DOUBLE_16,
            AppNumbers.DOUBLE_8,
            AppNumbers.DOUBLE_16,
            AppNumbers.DOUBLE_16,
          ),
          child: AppActionButton(onPressed: _save, label: AppStrings.productEditSaveButton),
        ),
      ),
    );
  }

  Future<void> _save() async {
    if (!(_formKey.currentState?.validate() ?? false)) return;
    final quantity = int.tryParse(_quantityController.text.trim()) ?? 0;

    final newAdjustment = widget.initialAdjustment + (quantity - widget.baseQuantity);
    final inventoryService = di<InventoryAdjustmentService>();
    await inventoryService.setAdjustment(widget.productCode, newAdjustment);

    final localProductService = di<LocalProductService>();
    final payload = <String, dynamic>{
      'productCode': widget.productCode,
      'productName': _nameController.text.trim(),
      'category': _category,
      'platform': _platform,
      'brand': _brand,
      'unit': _unit,
      'quantity': widget.baseQuantity,
      'purchasePrice': _parseCurrency(_priceController.text),
      'stockInDate': _dateController.text.trim(),
      'image': _imagePath ?? _imageUrl,
    };
    await localProductService.upsertProduct(payload);

    if (!mounted) return;
    AppToast.success(context, AppStrings.productAdjustSuccess);
    Navigator.of(context).maybePop();
  }

  int _parseCurrency(String value) {
    final digits = value.replaceAll(RegExp(r'[^0-9]'), '');
    return int.tryParse(digits) ?? 0;
  }

  String? _nonNegativeInt(String? value) {
    if (value == null || value.trim().isEmpty) {
      return AppStrings.stockInValidationRequired;
    }
    final parsed = int.tryParse(value.trim());
    if (parsed == null || parsed < 0) {
      return AppStrings.productAdjustInvalid;
    }
    return null;
  }

  DateTime? _tryParseDate(String value) {
    if (value.trim().isEmpty) return null;
    final parts = value.split('/');
    if (parts.length != 3) return null;
    final day = int.tryParse(parts[0]);
    final month = int.tryParse(parts[1]);
    final year = int.tryParse(parts[2]);
    if (day == null || month == null || year == null) return null;
    return DateTime(year, month, day);
  }

  String _formatDate(DateTime value) {
    final day = value.day.toString().padLeft(2, '0');
    final month = value.month.toString().padLeft(2, '0');
    return '$day/$month/${value.year}';
  }

  Future<void> _handlePickImage() async {
    final path = await AppImagePicker.pickImage(context);
    if (path == null || path.isEmpty) return;
    setState(() {
      _imagePath = path;
    });
  }

  void _handleClearImage() {
    setState(() {
      _imagePath = null;
      _imageUrl = null;
    });
  }
}

class _ProductEditImagePicker extends StatelessWidget {
  final String? image;
  final VoidCallback onPick;
  final VoidCallback onClear;

  const _ProductEditImagePicker({required this.image, required this.onPick, required this.onClear});

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
