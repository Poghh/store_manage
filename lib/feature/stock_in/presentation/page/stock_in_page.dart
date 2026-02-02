import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:store_manage/core/utils/app_dialog.dart';
import 'package:store_manage/core/utils/app_toast.dart';

import 'package:store_manage/core/constants/app_colors.dart';
import 'package:store_manage/core/constants/app_numbers.dart';
import 'package:store_manage/core/constants/app_strings.dart';
import 'package:store_manage/core/DI/di.dart';
import 'package:store_manage/core/navigation/home_tab_coordinator.dart';
import 'package:store_manage/core/data/sync/stock_in_sync_service.dart';
import 'package:store_manage/core/data/services/inventory_adjustment_service.dart';
import 'package:store_manage/core/data/services/local_product_service.dart';
import 'package:store_manage/core/widgets/app_page_app_bar.dart';
import 'package:store_manage/feature/product/data/repositories/product_repository.dart';
import 'package:store_manage/feature/product/presentation/cubit/product_search_cubit.dart';
import 'package:store_manage/core/network/connectivity_service.dart';
import 'package:store_manage/feature/stock_in/presentation/cubit/stock_in_cubit.dart';
import 'package:store_manage/feature/stock_in/presentation/cubit/stock_in_state.dart';
import 'package:store_manage/feature/stock_in/presentation/widgets/stock_in_form_controller.dart';
import 'package:store_manage/feature/stock_in/presentation/widgets/stock_in_body.dart';
import 'package:store_manage/feature/stock_in/presentation/widgets/stock_in_submit_button.dart';

@RoutePage()
class StockInPage extends StatefulWidget {
  final String? productCode;
  final String? productName;
  final String? category;
  final String? platform;
  final String? brand;
  final String? unit;
  final int? quantity;
  final int? purchasePrice;
  final String? stockInDate;

  const StockInPage({
    super.key,
    this.productCode,
    this.productName,
    this.category,
    this.platform,
    this.brand,
    this.unit,
    this.quantity,
    this.purchasePrice,
    this.stockInDate,
  });

  @override
  State<StockInPage> createState() => _StockInPageState();
}

class _StockInPageState extends State<StockInPage> {
  late final StockInFormController _formController;
  _PostSuccessAction _postSuccessAction = _PostSuccessAction.back;

  @override
  void initState() {
    super.initState();
    _formController = StockInFormController();
    _formController.applyPrefill(
      productCode: widget.productCode,
      productName: widget.productName,
      category: widget.category,
      platform: widget.platform,
      brand: widget.brand,
      unit: widget.unit,
      quantity: widget.quantity,
      purchasePrice: widget.purchasePrice,
      stockInDate: widget.stockInDate,
    );
  }

  @override
  void dispose() {
    _formController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<StockInCubit>(
          create: (_) => StockInCubit(
            di<StockInSyncService>(),
            di<ConnectivityService>(),
            di<InventoryAdjustmentService>(),
            di<LocalProductService>(),
          ),
        ),
        BlocProvider<ProductSearchCubit>(create: (_) => ProductSearchCubit(di<ProductRepository>())..prime()),
      ],
      child: BlocListener<StockInCubit, StockInState>(
        listener: (context, state) {
          if (state is StockInLoaded) {
            AppToast.success(context, AppStrings.stockInSubmitSuccess);
            _handlePostSuccessNavigation();
          } else if (state is StockInQueued) {
            AppToast.warning(context, state.message);
            _handlePostSuccessNavigation();
          } else if (state is StockInError) {
            AppToast.error(context, state.message);
          }
        },
        child: Builder(
          builder: (innerContext) => Scaffold(
            backgroundColor: AppColors.primary,
            appBar: AppPageAppBar(onBack: () => context.maybePop(), title: AppStrings.stockInTitle),
            body: SafeArea(
              bottom: false,
              child: SizedBox.expand(
                child: Container(
                  decoration: const BoxDecoration(
                    color: AppColors.background,
                    borderRadius: BorderRadius.vertical(top: Radius.circular(AppNumbers.DOUBLE_24)),
                  ),
                  child: StockInBody(formController: _formController),
                ),
              ),
            ),
            bottomNavigationBar: ListenableBuilder(
              listenable: _formController,
              builder: (context, child) => StockInSubmitButton(
                onPressed: _formController.isFormValid ? () => _submitStockIn(innerContext) : null,
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _submitStockIn(BuildContext context) {
    if (!_formController.validate()) {
      return;
    }
    if (_formController.hasLotChanged) {
      _confirmLotChange(context);
      return;
    }
    _postSuccessAction = _PostSuccessAction.back;
    final payload = _formController.buildPayload();
    context.read<StockInCubit>().submitStockIn(payload);
  }

  Future<void> _confirmLotChange(BuildContext context) async {
    final stockInCubit = context.read<StockInCubit>();
    AppDialog.confirm(
      context: context,
      title: AppStrings.stockInLotChangeTitle,
      message: AppStrings.stockInLotChangeMessage,
      confirmText: AppStrings.stockInLotCreateButton,
      cancelText: AppStrings.stockInLotUpdateButton,
      onConfirm: () async {
        Navigator.of(context).pop();
        if (!mounted) return;
        _postSuccessAction = _PostSuccessAction.openInventory;
        final payload = _formController.buildPayload();
        payload['_skipInventoryIncrease'] = true;
        stockInCubit.submitStockIn(payload);
      },
      onCancel: () {
        Navigator.of(context).pop();
        if (!mounted) return;
        _postSuccessAction = _PostSuccessAction.back;
        final payload = _formController.buildPayload();
        stockInCubit.submitStockIn(payload);
      },
    );
  }

  void _handlePostSuccessNavigation() {
    di<HomeTabCoordinator>().triggerInventoryRefresh();
    if (_postSuccessAction == _PostSuccessAction.openInventory) {
      di<HomeTabCoordinator>().requestedIndex.value = 2;
      context.router.popUntilRoot();
      _postSuccessAction = _PostSuccessAction.back;
      return;
    }
    context.maybePop();
    _postSuccessAction = _PostSuccessAction.back;
  }
}

enum _PostSuccessAction { back, openInventory }
