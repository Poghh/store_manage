import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:store_manage/core/constants/app_strings.dart';
import 'package:store_manage/core/utils/common_funtion_utils.dart';

class StockInFormController extends ChangeNotifier {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController productCodeController = TextEditingController();
  final TextEditingController productNameController = TextEditingController();
  final TextEditingController quantityController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final TextEditingController dateController = TextEditingController();

  String productCode = AppStrings.stockInAutoCodeValue;
  String? category;
  String? platform;
  String? brand;
  String? unit;
  String? imagePath;
  String? imageUrl;
  DateTime selectedDate = DateTime.now();
  int? _initialPurchasePrice;
  DateTime? _initialStockInDate;
  bool _hasPrefillProduct = false;

  StockInFormController() {
    dateController.text = CommonFuntionUtils.formatDateDDMMYYYY(selectedDate);
    productCodeController.text = productCode;

    // Listen to text changes to notify listeners
    productNameController.addListener(_onFormChanged);
    quantityController.addListener(_onFormChanged);
    priceController.addListener(_onFormChanged);
  }

  void _onFormChanged() {
    notifyListeners();
  }

  /// Check if form has minimum required data to enable submit button
  bool get isFormValid {
    final hasProductName = productNameController.text.trim().isNotEmpty;
    final hasQuantity = (int.tryParse(quantityController.text.trim()) ?? 0) > 0;
    final hasPrice = (CommonFuntionUtils.parseDigitsToInt(priceController.text) ?? 0) > 0;
    return hasProductName && hasQuantity && hasPrice;
  }

  void applyPrefill({
    String? productCode,
    String? productName,
    String? category,
    String? platform,
    String? brand,
    String? unit,
    int? quantity,
    int? purchasePrice,
    String? stockInDate,
    String? image,
  }) {
    if (productCode != null && productCode.trim().isNotEmpty) {
      this.productCode = productCode.trim();
      productCodeController.text = this.productCode;
      _hasPrefillProduct = true;
    }
    if (productName != null && productName.trim().isNotEmpty) {
      productNameController.text = productName.trim();
      _hasPrefillProduct = true;
    }
    if (category != null && category.trim().isNotEmpty) {
      this.category = category;
    }
    if (platform != null && platform.trim().isNotEmpty) {
      this.platform = platform;
    }
    if (brand != null && brand.trim().isNotEmpty) {
      this.brand = brand;
    }
    if (unit != null && unit.trim().isNotEmpty) {
      this.unit = unit;
    }
    if (image != null && image.trim().isNotEmpty) {
      imageUrl = image.trim();
    }
    if (quantity != null && quantity > 0) {
      quantityController.text = quantity.toString();
    }
    if (purchasePrice != null && purchasePrice > 0) {
      priceController.text = _formatCurrency(purchasePrice);
      _initialPurchasePrice = purchasePrice;
    }
    final parsedDate = CommonFuntionUtils.tryParseDateDDMMYYYY(stockInDate);
    if (parsedDate != null) {
      updateDate(parsedDate);
      _initialStockInDate = parsedDate;
    }
  }

  void resetSelectionForNewProduct() {
    productCode = AppStrings.stockInAutoCodeValue;
    productCodeController.text = productCode;
    category = null;
    platform = null;
    brand = null;
    unit = null;
    imagePath = null;
    imageUrl = null;
    quantityController.clear();
    priceController.clear();
  }

  @override
  void dispose() {
    productNameController.removeListener(_onFormChanged);
    quantityController.removeListener(_onFormChanged);
    priceController.removeListener(_onFormChanged);
    productCodeController.dispose();
    productNameController.dispose();
    quantityController.dispose();
    priceController.dispose();
    dateController.dispose();
    super.dispose();
  }

  bool validate() => formKey.currentState?.validate() ?? false;

  bool get hasPrefillProduct => _hasPrefillProduct;

  bool get hasLotChanged {
    if (!_hasPrefillProduct) return false;
    final currentPrice = CommonFuntionUtils.parseDigitsToInt(priceController.text);
    final priceChanged = _initialPurchasePrice != null && currentPrice != _initialPurchasePrice;
    final dateChanged =
        _initialStockInDate != null && !CommonFuntionUtils.isSameDay(selectedDate, _initialStockInDate!);
    return priceChanged || dateChanged;
  }

  Map<String, dynamic> buildPayload() {
    return {
      'productCode': productCode,
      'productName': productNameController.text.trim(),
      'category': category,
      'platform': platform,
      'brand': brand,
      'unit': unit,
      'image': imagePath ?? imageUrl,
      'quantity': int.tryParse(quantityController.text.trim()) ?? 0,
      'purchasePrice': CommonFuntionUtils.parseDigitsToInt(priceController.text) ?? 0,
      'stockInDate': CommonFuntionUtils.formatDateDDMMYYYY(selectedDate),
    };
  }

  String? get displayImage => imagePath ?? imageUrl;

  void updateDate(DateTime value) {
    selectedDate = value;
    dateController.text = CommonFuntionUtils.formatDateDDMMYYYY(value);
  }

  String _formatCurrency(int value) {
    final formatted = NumberFormat.decimalPattern(AppStrings.VIET_NAM_LOCALE).format(value);
    return '$formatted ${AppStrings.VIET_NAM_DONG_TEXT}';
  }
}
