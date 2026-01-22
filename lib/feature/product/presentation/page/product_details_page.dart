import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:store_manage/core/utils/app_dialog.dart';
import 'package:store_manage/core/utils/app_toast.dart';

import 'package:store_manage/core/DI/di.dart';
import 'package:store_manage/core/constants/app_colors.dart';
import 'package:store_manage/core/constants/app_font_sizes.dart';
import 'package:store_manage/core/constants/app_fonts.dart';
import 'package:store_manage/core/constants/app_numbers.dart';
import 'package:store_manage/core/constants/app_strings.dart';
import 'package:store_manage/core/network/connectivity_service.dart';
import 'package:store_manage/core/offline/product/product_delete_sync_service.dart';
import 'package:store_manage/core/services/inventory_adjustment_service.dart';
import 'package:store_manage/core/services/local_product_service.dart';
import 'package:store_manage/core/utils/common_funtion_utils.dart';
import 'package:store_manage/core/widgets/app_action_button.dart';
import 'package:store_manage/feature/product/data/repositories/product_repository.dart';
import 'package:store_manage/feature/product/presentation/page/product_edit_page.dart';
import 'package:store_manage/feature/product/presentation/widgets/info_row.dart';
import 'package:store_manage/feature/product/presentation/widgets/product_detail_actions.dart';
import 'package:store_manage/feature/product/presentation/widgets/product_header_card.dart';

@RoutePage()
class ProductDetailsPage extends StatefulWidget {
  final String productCode;
  final String productName;
  final String category;
  final String platform;
  final String brand;
  final String unit;
  final String quantity;
  final String purchasePrice;
  final String stockInDate;
  final String? imageUrl;
  final int? stockQuantityValue;
  final int? priceValue;

  const ProductDetailsPage({
    super.key,
    this.productCode = '',
    this.productName = '',
    this.category = '',
    this.platform = '',
    this.brand = '',
    this.unit = '',
    this.quantity = '',
    this.purchasePrice = '',
    this.stockInDate = '',
    this.imageUrl,
    this.stockQuantityValue,
    this.priceValue,
  });

  @override
  State<ProductDetailsPage> createState() => _ProductDetailsPageState();
}

class _ProductDetailsPageState extends State<ProductDetailsPage> {
  late final InventoryAdjustmentService _inventoryService;
  late final LocalProductService _localProductService;
  late final ProductRepository _productRepository;
  late final ProductDeleteSyncService _deleteSyncService;
  late final ConnectivityService _connectivity;
  late final int _baseQuantity;
  late final bool _hasQuantity;
  late final int _initialAdjustment;
  late final Listenable _listenable;

  @override
  void initState() {
    super.initState();
    _inventoryService = di<InventoryAdjustmentService>();
    _localProductService = di<LocalProductService>();
    _productRepository = di<ProductRepository>();
    _deleteSyncService = di<ProductDeleteSyncService>();
    _connectivity = di<ConnectivityService>();
    _listenable = Listenable.merge([_inventoryService.listenable, _localProductService.listenable]);
    _baseQuantity = widget.stockQuantityValue ?? int.tryParse(widget.quantity.replaceAll(RegExp(r'[^0-9]'), '')) ?? 0;
    _hasQuantity = widget.quantity.isNotEmpty || widget.stockQuantityValue != null;
    _initialAdjustment = _inventoryService.getAdjustment(widget.productCode);
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _listenable,
      builder: (context, child) {
        final localOverride = _localProductService.getByCode(widget.productCode);
        final overrideName = (localOverride?['productName'] ?? '').toString();
        final overridePrice = localOverride?['purchasePrice'];
        final overrideDate = (localOverride?['stockInDate'] ?? '').toString();
        final displayCode = widget.productCode.isEmpty ? '' : widget.productCode;
        final displayName = overrideName.isNotEmpty
            ? overrideName
            : (widget.productName.isEmpty ? '' : widget.productName);
        final displayCategory = widget.category.isEmpty ? '' : widget.category;
        final displayPlatform = widget.platform.isEmpty ? '' : widget.platform;
        final displayBrand = widget.brand.isEmpty ? '' : widget.brand;
        final displayUnit = widget.unit.isEmpty ? '' : widget.unit;
        final currentAdjustment = _inventoryService.getAdjustment(widget.productCode);
        final delta = currentAdjustment - _initialAdjustment;
        final adjustedQuantity = (_baseQuantity + delta).clamp(0, 1 << 30);
        final displayQuantity = _hasQuantity ? adjustedQuantity.toString() : '';
        final parsedOverridePrice = overridePrice is int ? overridePrice : int.tryParse('${overridePrice ?? ''}');
        final displayPrice = widget.purchasePrice.isNotEmpty
            ? widget.purchasePrice
            : (parsedOverridePrice == null
                  ? (widget.priceValue == null ? '' : CommonFuntionUtils.formatCurrency(widget.priceValue!))
                  : CommonFuntionUtils.formatCurrency(parsedOverridePrice));
        final displayDate = overrideDate.isNotEmpty
            ? overrideDate
            : (widget.stockInDate.isEmpty ? '' : widget.stockInDate);
        final hasPrefill = widget.productCode.isNotEmpty || widget.productName.isNotEmpty;
        final prefillQuantity = _hasQuantity ? adjustedQuantity : null;
        final prefillPrice =
            parsedOverridePrice ??
            widget.priceValue ??
            int.tryParse(widget.purchasePrice.replaceAll(RegExp(r'[^0-9]'), ''));
        final infoItems = [
          _InfoItem(AppStrings.stockInProductCodeLabel, displayCode),
          _InfoItem(AppStrings.stockInProductNameLabel, displayName),
          _InfoItem(AppStrings.stockInCategoryLabel, displayCategory),
          _InfoItem(AppStrings.stockInPlatformLabel, displayPlatform),
          _InfoItem(AppStrings.stockInBrandLabel, displayBrand),
          _InfoItem(AppStrings.stockInUnitLabel, displayUnit),
          _InfoItem(AppStrings.stockInQuantityLabel, displayQuantity),
          _InfoItem(AppStrings.stockInPurchasePriceLabel, displayPrice),
          _InfoItem(AppStrings.stockInDateLabel, displayDate),
        ];

        return Scaffold(
          backgroundColor: AppColors.background,
          appBar: AppBar(
            backgroundColor: AppColors.background,
            elevation: AppNumbers.DOUBLE_0,
            scrolledUnderElevation: AppNumbers.DOUBLE_0,
            surfaceTintColor: AppColors.background,
            leading: IconButton(
              onPressed: () => context.maybePop(),
              icon: const Icon(Icons.arrow_back, color: AppColors.textPrimary),
            ),
            title: const Text(
              AppStrings.productDetailsTitle,
              style: TextStyle(
                fontSize: AppFontSizes.fontSize18,
                fontWeight: FontWeight.w600,
                fontFamily: AppFonts.inter,
                color: AppColors.textPrimary,
              ),
            ),
          ),
          body: SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(AppNumbers.DOUBLE_16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ProductHeaderCard(
                    imageUrl: widget.imageUrl,
                    productName: displayName,
                    productCode: displayCode,
                    quantity: displayQuantity,
                  ),
                  const SizedBox(height: AppNumbers.DOUBLE_16),
                  ...infoItems.map((item) => InfoRow(label: item.label, value: item.value)),
                  const SizedBox(height: AppNumbers.DOUBLE_16),
                  AppActionButton(
                    onPressed: () => Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (_) => ProductEditPage(
                          productCode: widget.productCode,
                          productName: displayName,
                          category: widget.category,
                          platform: widget.platform,
                          brand: widget.brand,
                          unit: widget.unit,
                          purchasePrice: displayPrice,
                          stockInDate: displayDate,
                          imageUrl: widget.imageUrl,
                          baseQuantity: _baseQuantity,
                          initialAdjustment: _initialAdjustment,
                        ),
                      ),
                    ),
                    label: AppStrings.productEditButton,
                    backgroundColor: AppColors.primaryLight,
                    foregroundColor: AppColors.primary,
                    borderColor: AppColors.primary,
                  ),
                  const SizedBox(height: AppNumbers.DOUBLE_12),
                  AppActionButton(
                    onPressed: () => _confirmDelete(displayCode),
                    label: AppStrings.productDeleteButton,
                    backgroundColor: AppColors.error,
                    foregroundColor: AppColors.textOnPrimary,
                  ),
                ],
              ),
            ),
          ),
          bottomNavigationBar: ProductDetailActions(
            displayCode: displayCode,
            displayName: displayName,
            displayQuantity: displayQuantity,
            displayPrice: displayPrice,
            priceValue: widget.priceValue,
            imageUrl: widget.imageUrl,
            productCode: hasPrefill ? widget.productCode : null,
            productName: hasPrefill ? widget.productName : null,
            category: widget.category.isNotEmpty ? widget.category : null,
            platform: widget.platform.isNotEmpty ? widget.platform : null,
            brand: widget.brand.isNotEmpty ? widget.brand : null,
            unit: widget.unit.isNotEmpty ? widget.unit : null,
            quantity: prefillQuantity,
            purchasePrice: prefillPrice,
            stockInDate: displayDate.isNotEmpty ? displayDate : null,
          ),
        );
      },
    );
  }

  Future<void> _confirmDelete(String productCode) async {
    if (productCode.trim().isEmpty) return;
    AppDialog.confirm(
      context: context,
      title: AppStrings.productDeleteConfirmTitle,
      message: AppStrings.productDeleteConfirmMessage,
      confirmText: AppStrings.productDeleteConfirm,
      cancelText: AppStrings.productDeleteCancel,
      onConfirm: () async {
        Navigator.of(context).pop();
        await _deleteProduct(productCode);
      },
      onCancel: () => Navigator.of(context).pop(),
    );
  }

  Future<void> _deleteProduct(String productCode) async {
    final code = productCode.trim();
    if (code.isEmpty) return;

    if (!await _connectivity.isOnline) {
      await _deleteSyncService.enqueue(code);
      await _localProductService.deleteProduct(code);
      await _inventoryService.setAdjustment(code, 0);
      if (!mounted) return;
      AppToast.warning(context, AppStrings.productDeleteQueued);
      context.maybePop();
      return;
    }

    try {
      await _productRepository.deleteProduct(code);
      await _localProductService.deleteProduct(code);
      await _inventoryService.setAdjustment(code, 0);
      if (!mounted) return;
      AppToast.success(context, AppStrings.productDeleteSuccess);
      context.maybePop();
    } catch (_) {
      await _deleteSyncService.enqueue(code);
      await _localProductService.deleteProduct(code);
      await _inventoryService.setAdjustment(code, 0);
      if (!mounted) return;
      AppToast.warning(context, AppStrings.productDeleteQueued);
      context.maybePop();
    }
  }
}

class _InfoItem {
  final String label;
  final String value;

  const _InfoItem(this.label, this.value);
}
