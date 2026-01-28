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
import 'package:store_manage/core/navigation/home_tab_coordinator.dart';
import 'package:store_manage/core/network/connectivity_service.dart';
import 'package:store_manage/core/data/sync/product_delete_sync_service.dart';
import 'package:store_manage/core/data/services/inventory_adjustment_service.dart';
import 'package:store_manage/core/data/services/local_product_service.dart';
import 'package:store_manage/core/utils/common_funtion_utils.dart';
import 'package:store_manage/feature/product/data/repositories/product_repository.dart';
import 'package:store_manage/feature/product/presentation/page/product_edit_page.dart';
import 'package:store_manage/feature/product/presentation/widgets/info_row.dart';
import 'package:store_manage/feature/product/presentation/widgets/product_detail_actions.dart';
import 'package:store_manage/feature/product/presentation/widgets/product_details_body.dart';

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
  late final HomeTabCoordinator _tabCoordinator;
  late final int _baseQuantity;
  late final bool _hasQuantity;

  bool _isLoading = true;
  int _initialAdjustment = 0;
  int _currentAdjustment = 0;
  Map<String, dynamic>? _localOverride;

  @override
  void initState() {
    super.initState();
    _inventoryService = di<InventoryAdjustmentService>();
    _localProductService = di<LocalProductService>();
    _productRepository = di<ProductRepository>();
    _deleteSyncService = di<ProductDeleteSyncService>();
    _connectivity = di<ConnectivityService>();
    _tabCoordinator = di<HomeTabCoordinator>();
    _tabCoordinator.inventoryRefreshTrigger.addListener(_onRefreshTriggered);
    _baseQuantity = widget.stockQuantityValue ?? int.tryParse(widget.quantity.replaceAll(RegExp(r'[^0-9]'), '')) ?? 0;
    _hasQuantity = widget.quantity.isNotEmpty || widget.stockQuantityValue != null;
    _loadData();
  }

  @override
  void dispose() {
    _tabCoordinator.inventoryRefreshTrigger.removeListener(_onRefreshTriggered);
    super.dispose();
  }

  void _onRefreshTriggered() {
    _refreshData();
  }

  Future<void> _loadData() async {
    final adjustment = await _inventoryService.getAdjustment(widget.productCode);
    final localOverride = await _localProductService.getByCode(widget.productCode);
    if (mounted) {
      setState(() {
        _initialAdjustment = adjustment;
        _currentAdjustment = adjustment;
        _localOverride = localOverride;
        _isLoading = false;
      });
    }
  }

  Future<void> _refreshData() async {
    final adjustment = await _inventoryService.getAdjustment(widget.productCode);
    final localOverride = await _localProductService.getByCode(widget.productCode);
    if (mounted) {
      setState(() {
        _currentAdjustment = adjustment;
        _localOverride = localOverride;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return Scaffold(
        backgroundColor: AppColors.background,
        appBar: AppBar(
          backgroundColor: AppColors.background,
          elevation: AppNumbers.DOUBLE_0,
          leading: IconButton(
            onPressed: () => context.maybePop(),
            icon: const Icon(Icons.arrow_back, color: AppColors.textPrimary),
          ),
        ),
        body: const Center(child: CircularProgressIndicator()),
      );
    }

    final overrideName = (_localOverride?['productName'] ?? '').toString();
    final overridePrice = _localOverride?['purchasePrice'];
    final overrideDate = (_localOverride?['stockInDate'] ?? '').toString();
    final displayCode = widget.productCode.isEmpty ? '' : widget.productCode;
    final displayName = overrideName.isNotEmpty
        ? overrideName
        : (widget.productName.isEmpty ? '' : widget.productName);
    final displayCategory = widget.category.isEmpty ? '' : widget.category;
    final displayPlatform = widget.platform.isEmpty ? '' : widget.platform;
    final displayBrand = widget.brand.isEmpty ? '' : widget.brand;
    final displayUnit = widget.unit.isEmpty ? '' : widget.unit;
    final delta = _currentAdjustment - _initialAdjustment;
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
    final infoRows = [
      InfoRow(label: AppStrings.stockInProductCodeLabel, value: displayCode),
      InfoRow(label: AppStrings.stockInProductNameLabel, value: displayName),
      InfoRow(label: AppStrings.stockInCategoryLabel, value: displayCategory),
      InfoRow(label: AppStrings.stockInPlatformLabel, value: displayPlatform),
      InfoRow(label: AppStrings.stockInBrandLabel, value: displayBrand),
      InfoRow(label: AppStrings.stockInUnitLabel, value: displayUnit),
      InfoRow(label: AppStrings.stockInQuantityLabel, value: displayQuantity),
      InfoRow(label: AppStrings.stockInPurchasePriceLabel, value: displayPrice),
      InfoRow(label: AppStrings.stockInDateLabel, value: displayDate),
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
          child: ProductDetailsBody(
            displayName: displayName,
            displayCode: displayCode,
            displayQuantity: displayQuantity,
            imageUrl: widget.imageUrl,
            infoRows: infoRows,
            onEdit: () async {
              await Navigator.of(context).push(
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
              );
              _refreshData();
            },
            onDelete: () => _confirmDelete(displayCode),
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
