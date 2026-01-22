import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:store_manage/core/utils/app_toast.dart';

import 'package:store_manage/core/DI/di.dart';
import 'package:store_manage/core/constants/app_colors.dart';
import 'package:store_manage/core/constants/app_font_sizes.dart';
import 'package:store_manage/core/constants/app_fonts.dart';
import 'package:store_manage/core/constants/app_numbers.dart';
import 'package:store_manage/core/constants/app_strings.dart';
import 'package:store_manage/feature/home/presentation/widgets/product_search_bar.dart';
import 'package:store_manage/feature/product/data/models/product.dart';
import 'package:store_manage/feature/product/data/repositories/product_repository.dart';
import 'package:store_manage/feature/product/presentation/cubit/product_search_cubit.dart';
import 'package:store_manage/feature/retail/presentation/cubit/retail_cubit.dart';
import 'package:store_manage/feature/retail/presentation/cubit/retail_state.dart';
import 'package:store_manage/feature/retail/data/repositories/retail_repository.dart';
import 'package:store_manage/core/network/connectivity_service.dart';
import 'package:store_manage/core/offline/retail/retail_sync_service.dart';
import 'package:store_manage/core/services/inventory_adjustment_service.dart';
import 'package:store_manage/core/storage/retail_transaction_storage.dart';
import 'package:store_manage/feature/retail/presentation/widgets/payment_method.dart';
import 'package:store_manage/feature/retail/presentation/widgets/retail_content.dart';

@RoutePage()
class RetailPage extends StatefulWidget {
  final String productCode;
  final String productName;
  final int stockQuantity;
  final int price;
  final String? imageUrl;

  const RetailPage({
    super.key,
    this.productCode = '',
    this.productName = '',
    this.stockQuantity = 0,
    this.price = 0,
    this.imageUrl,
  });

  @override
  State<RetailPage> createState() => _RetailPageState();
}

class _RetailPageState extends State<RetailPage> {
  int _quantity = 1;
  String _selectedCode = '';
  String _selectedName = '';
  int _selectedStock = 0;
  String? _selectedImageUrl;
  int _purchasePrice = 0;
  int _sellPrice = 0;
  PaymentMethod _paymentMethod = PaymentMethod.cash;
  late final TextEditingController _priceController;
  final NumberFormat _priceFormat = NumberFormat.decimalPattern(AppStrings.VIET_NAM_LOCALE);

  int get _total => _quantity * _sellPrice;

  @override
  void initState() {
    super.initState();
    _selectedCode = widget.productCode;
    _selectedName = widget.productName;
    _selectedStock = widget.stockQuantity;
    _selectedImageUrl = widget.imageUrl;
    _purchasePrice = widget.price;
    _sellPrice = 0;
    _priceController = TextEditingController(text: _formatPriceText(_sellPrice));
  }

  @override
  void dispose() {
    _priceController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final displayName = _selectedName;
    final displayCode = _selectedCode;
    final displayStock = _selectedStock;
    final displayImage = _selectedImageUrl;

    final hasProduct = _selectedCode.isNotEmpty || _selectedName.isNotEmpty;
    return MultiBlocProvider(
      providers: [
        BlocProvider<ProductSearchCubit>(create: (_) => ProductSearchCubit(di<ProductRepository>())..prime()),
        BlocProvider<RetailCubit>(
          create: (_) => RetailCubit(
            di<RetailRepository>(),
            di<RetailSyncService>(),
            di<ConnectivityService>(),
            di<RetailTransactionStorage>(),
            di<InventoryAdjustmentService>(),
          ),
        ),
      ],
      child: BlocListener<RetailCubit, RetailState>(
        listener: (context, state) {
          if (state is RetailLoaded) {
            AppToast.success(context, AppStrings.retailSubmitSuccess);
            _applyLocalSale();
            context.maybePop();
          } else if (state is RetailQueued) {
            AppToast.warning(context, state.message);
            _applyLocalSale();
            context.maybePop();
          } else if (state is RetailError) {
            AppToast.error(context, state.message);
          }
        },
        child: Builder(
          builder: (innerContext) => Scaffold(
            backgroundColor: AppColors.primary,
            appBar: AppBar(
              backgroundColor: AppColors.primary,
              elevation: AppNumbers.DOUBLE_0,
              scrolledUnderElevation: AppNumbers.DOUBLE_0,
              surfaceTintColor: AppColors.primary,
              leading: IconButton(
                onPressed: () => context.maybePop(),
                icon: const Icon(Icons.arrow_back, color: AppColors.textOnPrimary),
              ),
              title: const Text(
                AppStrings.retailTitle,
                style: TextStyle(
                  fontSize: AppFontSizes.fontSize18,
                  fontWeight: FontWeight.w600,
                  fontFamily: AppFonts.inter,
                  color: AppColors.textOnPrimary,
                ),
              ),
              actions: const [
                Padding(
                  padding: EdgeInsets.only(right: AppNumbers.DOUBLE_12),
                  child: Icon(Icons.local_offer_outlined, color: AppColors.textOnPrimary),
                ),
              ],
            ),
            body: SafeArea(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(AppNumbers.DOUBLE_16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ProductSearchBar(
                      hintText: AppStrings.retailSearchPlaceholder,
                      iconColor: AppColors.textMuted,
                      onSelected: _onProductSelected,
                    ),
                    const SizedBox(height: AppNumbers.DOUBLE_12),
                    if (hasProduct)
                      RetailContent(
                        displayName: displayName,
                        displayCode: displayCode,
                        displayStock: displayStock,
                        displayImage: displayImage,
                        quantity: _quantity,
                        onDecrease: () => setState(() => _quantity = _quantity > 1 ? _quantity - 1 : 1),
                        onIncrease: () => _increaseQuantity(innerContext),
                        priceController: _priceController,
                        onPriceChanged: _onPriceChanged,
                        purchasePrice: _purchasePrice,
                        total: _total,
                        paymentMethod: _paymentMethod,
                        paymentMethodLabel: _paymentMethodLabel,
                        onPaymentChanged: (value) => setState(() => _paymentMethod = value),
                        onConfirm: () => _submitRetail(innerContext),
                      ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _submitRetail(BuildContext context) {
    if (_selectedCode.isEmpty) {
      AppToast.warning(context, AppStrings.retailValidationSelectProduct);
      return;
    }
    if (_sellPrice <= 0) {
      AppToast.warning(context, AppStrings.retailValidationPrice);
      return;
    }
    if (_quantity > _selectedStock) {
      AppToast.warning(context, AppStrings.retailValidationQuantityExceed);
      return;
    }

    final payload = {
      'productCode': _selectedCode,
      'productName': _selectedName,
      'quantity': _quantity,
      'sellPrice': _sellPrice,
      'purchasePrice': _purchasePrice,
      'total': _total,
      'paymentMethod': _paymentMethod.name,
      'createdAt': DateTime.now().toIso8601String(),
    };

    context.read<RetailCubit>().submitRetailSale(payload);
  }

  void _increaseQuantity(BuildContext context) {
    if (_quantity >= _selectedStock) {
      AppToast.warning(context, AppStrings.retailValidationQuantityExceed);
      return;
    }
    setState(() => _quantity = _quantity + 1);
  }

  void _applyLocalSale() {
    if (_selectedStock <= 0) return;
    final updatedStock = (_selectedStock - _quantity).clamp(0, 1 << 30);
    setState(() {
      _selectedStock = updatedStock;
      if (_selectedStock <= 0) {
        _quantity = 1;
      } else if (_quantity > _selectedStock) {
        _quantity = _selectedStock;
      }
    });
  }

  void _onProductSelected(Product product) {
    setState(() {
      _selectedCode = product.productCode;
      _selectedName = product.productName;
      _selectedStock = product.quantity ?? 0;
      _selectedImageUrl = product.image;
      _purchasePrice = product.purchasePrice ?? 0;
      _sellPrice = 0;
      _priceController.text = _formatPriceText(_sellPrice);
      _quantity = 1;
    });
  }

  void _onPriceChanged(String value) {
    final digits = value.replaceAll(RegExp(r'[^0-9]'), '');
    final parsed = int.tryParse(digits) ?? 0;
    setState(() {
      _sellPrice = parsed;
    });
  }

  String _formatPriceText(int value) {
    if (value <= 0) return '';
    return _priceFormat.format(value);
  }

  String get _paymentMethodLabel {
    switch (_paymentMethod) {
      case PaymentMethod.cash:
        return AppStrings.retailCashLabel;
      case PaymentMethod.transfer:
        return AppStrings.retailTransferLabel;
    }
  }
}
