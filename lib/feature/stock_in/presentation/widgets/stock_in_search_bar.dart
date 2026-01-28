import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:store_manage/core/constants/app_colors.dart';
import 'package:store_manage/core/constants/app_numbers.dart';
import 'package:store_manage/core/constants/app_strings.dart';
import 'package:store_manage/core/widgets/app_search_field.dart';
import 'package:store_manage/core/widgets/app_product_thumbnail.dart';
import 'package:store_manage/feature/product/data/models/product.dart';
import 'package:store_manage/feature/product/presentation/cubit/product_search_cubit.dart';
import 'package:store_manage/feature/product/presentation/cubit/product_search_state.dart';

class StockInSearchBar extends StatefulWidget {
  final TextEditingController controller;
  final ValueChanged<Product>? onSelected;
  final ValueChanged<String>? onChanged;
  final FormFieldValidator<String>? validator;
  final AutovalidateMode? autovalidateMode;
  final String hintText;

  const StockInSearchBar({
    super.key,
    required this.controller,
    this.onSelected,
    this.onChanged,
    this.validator,
    this.autovalidateMode,
    this.hintText = AppStrings.stockInProductNameHint,
  });

  @override
  State<StockInSearchBar> createState() => _StockInSearchBarState();
}

class _StockInSearchBarState extends State<StockInSearchBar> {
  late final FocusNode _focusNode;
  final LayerLink _layerLink = LayerLink();
  OverlayEntry? _overlayEntry;
  ProductSearchCubit? _searchCubit;

  @override
  void initState() {
    super.initState();
    _focusNode = FocusNode();
    _focusNode.addListener(_handleFocusChange);
  }

  @override
  void dispose() {
    _hideOverlay();
    _focusNode.removeListener(_handleFocusChange);
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _searchCubit ??= context.read<ProductSearchCubit>();
    return BlocListener<ProductSearchCubit, ProductSearchState>(
      listenWhen: (previous, current) => previous.results != current.results || previous.isLoading != current.isLoading,
      listener: (context, state) {
        _updateOverlay(state);
      },
      child: CompositedTransformTarget(
        link: _layerLink,
        child: AppSearchField(
          controller: widget.controller,
          focusNode: _focusNode,
          hintText: widget.hintText,
          iconColor: AppColors.textMuted,
          onChanged: (value) {
            widget.onChanged?.call(value);
            context.read<ProductSearchCubit>().search(value);
          },
          validator: widget.validator,
          autovalidateMode: widget.autovalidateMode,
          trailing: Container(
            height: AppNumbers.DOUBLE_32,
            width: AppNumbers.DOUBLE_32,
            decoration: BoxDecoration(
              color: AppColors.primaryLight,
              borderRadius: BorderRadius.circular(AppNumbers.DOUBLE_8),
            ),
            child: const Icon(Icons.qr_code_scanner, size: AppNumbers.DOUBLE_18, color: AppColors.primary),
          ),
        ),
      ),
    );
  }

  void _handleFocusChange() {
    if (!_focusNode.hasFocus) {
      _hideOverlay();
      return;
    }
    _updateOverlay(_searchCubit?.state ?? const ProductSearchState());
  }

  void _updateOverlay(ProductSearchState state) {
    if (!_focusNode.hasFocus || widget.controller.text.trim().isEmpty) {
      _hideOverlay();
      return;
    }

    if (state.results.isEmpty && !state.isLoading) {
      _hideOverlay();
      return;
    }

    _overlayEntry?.markNeedsBuild();
    if (_overlayEntry == null) {
      _overlayEntry = _buildOverlayEntry();
      Overlay.of(context).insert(_overlayEntry!);
    }
  }

  OverlayEntry _buildOverlayEntry() {
    final textTheme = Theme.of(context).textTheme;
    return OverlayEntry(
      builder: (context) {
        final state = _searchCubit?.state ?? const ProductSearchState();
        final renderBox = this.context.findRenderObject() as RenderBox?;
        final size = renderBox?.size ?? Size.zero;
        final offset = renderBox?.localToGlobal(Offset.zero) ?? Offset.zero;
        final screenHeight = MediaQuery.of(context).size.height;
        final availableHeight = screenHeight - offset.dy - size.height - AppNumbers.DOUBLE_16;
        const fixedMaxHeight = 220.0;
        final maxHeight = availableHeight > 0 ? availableHeight.clamp(120.0, fixedMaxHeight) : fixedMaxHeight;

        return Positioned(
          width: size.width,
          child: CompositedTransformFollower(
            link: _layerLink,
            showWhenUnlinked: false,
            offset: Offset(0, size.height + AppNumbers.DOUBLE_8),
            child: Material(
              elevation: AppNumbers.DOUBLE_4,
              borderRadius: BorderRadius.circular(AppNumbers.DOUBLE_12),
              child: Container(
                decoration: BoxDecoration(
                  color: AppColors.surface,
                  borderRadius: BorderRadius.circular(AppNumbers.DOUBLE_12),
                  border: Border.all(color: AppColors.border),
                ),
                child: state.isLoading
                    ? const Padding(
                        padding: EdgeInsets.all(AppNumbers.DOUBLE_12),
                        child: LinearProgressIndicator(minHeight: AppNumbers.DOUBLE_2),
                      )
                    : ConstrainedBox(
                        constraints: BoxConstraints(maxHeight: maxHeight),
                        child: ListView.separated(
                          padding: EdgeInsets.zero,
                          itemCount: state.results.length,
                          separatorBuilder: (context, index) =>
                              Divider(height: AppNumbers.DOUBLE_1, color: AppColors.border),
                          itemBuilder: (context, index) {
                            final item = state.results[index];
                            return InkWell(
                              onTap: () {
                                widget.controller.text = item.productName;
                                widget.onSelected?.call(item);
                                _searchCubit?.clear();
                                _hideOverlay();
                                if (kDebugMode) {
                                  print("Selected product: ${item.productName}");
                                }
                              },
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: AppNumbers.DOUBLE_12,
                                  vertical: AppNumbers.DOUBLE_12,
                                ),
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(item.productName, style: textTheme.titleSmall),
                                          const SizedBox(height: AppNumbers.DOUBLE_4),
                                          Text(item.productCode, style: textTheme.labelMedium),
                                        ],
                                      ),
                                    ),
                                    if (item.image != null && item.image!.isNotEmpty)
                                      AppProductThumbnail(
                                        imageUrl: item.image,
                                        size: AppNumbers.DOUBLE_40,
                                        borderRadius: AppNumbers.DOUBLE_8,
                                        padding: AppNumbers.DOUBLE_4,
                                        placeholderIcon: Icons.phone_iphone,
                                        placeholderColor: AppColors.primary,
                                        placeholderSize: AppNumbers.DOUBLE_24,
                                        backgroundColor: AppColors.background,
                                      ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      ),
              ),
            ),
          ),
        );
      },
    );
  }

  void _hideOverlay() {
    _overlayEntry?.remove();
    _overlayEntry = null;
  }
}
