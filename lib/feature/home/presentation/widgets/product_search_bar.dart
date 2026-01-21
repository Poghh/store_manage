import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:store_manage/core/constants/app_colors.dart';
import 'package:store_manage/core/constants/app_font_sizes.dart';
import 'package:store_manage/core/constants/app_fonts.dart';
import 'package:store_manage/core/constants/app_numbers.dart';
import 'package:store_manage/core/constants/app_strings.dart';
import 'package:store_manage/feature/product/data/models/product.dart';
import 'package:store_manage/feature/product/presentation/cubit/product_search_cubit.dart';
import 'package:store_manage/feature/product/presentation/cubit/product_search_state.dart';

class ProductSearchBar extends StatefulWidget {
  final ValueChanged<Product>? onSelected;
  final String hintText;
  final Color iconColor;

  const ProductSearchBar({
    super.key,
    this.onSelected,
    this.hintText = AppStrings.homeProductSearchPlaceholder,
    this.iconColor = AppColors.textSecondary,
  });

  @override
  State<ProductSearchBar> createState() => _ProductSearchBarState();
}

class _ProductSearchBarState extends State<ProductSearchBar> {
  late final TextEditingController _controller;
  late final FocusNode _focusNode;
  final LayerLink _layerLink = LayerLink();
  OverlayEntry? _overlayEntry;
  ProductSearchCubit? _searchCubit;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
    _focusNode = FocusNode();
    _focusNode.addListener(_handleFocusChange);
  }

  @override
  void dispose() {
    _hideOverlay();
    _focusNode.removeListener(_handleFocusChange);
    _controller.dispose();
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
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: AppNumbers.DOUBLE_12, vertical: AppNumbers.DOUBLE_8),
          decoration: BoxDecoration(
            color: AppColors.surface,
            borderRadius: BorderRadius.circular(AppNumbers.DOUBLE_12),
            border: Border.all(color: AppColors.border),
          ),
          child: Row(
            children: [
              Icon(Icons.search, size: AppNumbers.DOUBLE_20, color: widget.iconColor),
              const SizedBox(width: AppNumbers.DOUBLE_8),
              Expanded(
                child: TextField(
                  controller: _controller,
                  focusNode: _focusNode,
                  decoration: InputDecoration(hintText: widget.hintText, border: InputBorder.none, isDense: true),
                  style: const TextStyle(
                    fontSize: AppFontSizes.fontSize14,
                    fontWeight: FontWeight.w500,
                    color: AppColors.textPrimary,
                    fontFamily: AppFonts.inter,
                  ),
                  onChanged: (value) => context.read<ProductSearchCubit>().search(value),
                ),
              ),
              Icon(Icons.qr_code_scanner, size: AppNumbers.DOUBLE_20, color: widget.iconColor),
            ],
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
    if (!_focusNode.hasFocus || _controller.text.trim().isEmpty) {
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
    return OverlayEntry(
      builder: (context) {
        final state = _searchCubit?.state ?? const ProductSearchState();
        final renderBox = this.context.findRenderObject() as RenderBox?;
        final size = renderBox?.size ?? Size.zero;
        final offset = renderBox?.localToGlobal(Offset.zero) ?? Offset.zero;
        final screenHeight = MediaQuery.of(context).size.height;
        final availableHeight = screenHeight - offset.dy - size.height - AppNumbers.DOUBLE_16;
        const fixedMaxHeight = 145.0;
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
                          separatorBuilder: (context, index) => const Divider(height: 1, color: AppColors.border),
                          itemBuilder: (context, index) {
                            final item = state.results[index];
                            return InkWell(
                              onTap: () {
                                _controller.text = item.productName;
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
                                          Text(
                                            item.productName,
                                            style: const TextStyle(
                                              fontSize: AppFontSizes.fontSize14,
                                              fontWeight: FontWeight.w600,
                                              fontFamily: AppFonts.inter,
                                              color: AppColors.textPrimary,
                                            ),
                                          ),
                                          const SizedBox(height: AppNumbers.DOUBLE_4),
                                          Text(
                                            item.productCode,
                                            style: const TextStyle(
                                              fontSize: AppFontSizes.fontSize12,
                                              fontWeight: FontWeight.w500,
                                              fontFamily: AppFonts.inter,
                                              color: AppColors.textMuted,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    if (item.image != null && item.image!.isNotEmpty)
                                      ClipRRect(
                                        borderRadius: BorderRadius.circular(AppNumbers.DOUBLE_8),
                                        child: Container(
                                          width: AppNumbers.DOUBLE_40,
                                          height: AppNumbers.DOUBLE_40,
                                          color: AppColors.background,
                                          padding: const EdgeInsets.all(AppNumbers.DOUBLE_4),
                                          child: Image.network(item.image!, fit: BoxFit.contain),
                                        ),
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
