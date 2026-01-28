import 'package:flutter/material.dart';

import 'package:store_manage/core/constants/app_colors.dart';
import 'package:store_manage/core/constants/app_numbers.dart';
import 'package:store_manage/core/constants/app_strings.dart';
import 'package:store_manage/core/widgets/app_field_container.dart';

class BankSearchBar extends StatefulWidget {
  final ValueChanged<String>? onSelected;
  final List<String> banks;
  final String hintText;

  const BankSearchBar({super.key, required this.banks, this.onSelected, this.hintText = AppStrings.bankLabel});

  @override
  State<BankSearchBar> createState() => _BankSearchBarState();
}

class _BankSearchBarState extends State<BankSearchBar> {
  late final TextEditingController _controller;
  late final FocusNode _focusNode;
  final LayerLink _layerLink = LayerLink();
  OverlayEntry? _overlayEntry;

  List<String> _results = [];

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
    _focusNode = FocusNode()..addListener(_handleFocusChange);
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
    return CompositedTransformTarget(
      link: _layerLink,
      child: AppFieldContainer(
        child: TextField(
          controller: _controller,
          focusNode: _focusNode,
          decoration: const InputDecoration(border: InputBorder.none, isDense: true, hintText: AppStrings.bankHint),
          onChanged: _onChanged,
        ),
      ),
    );
  }

  void _onChanged(String value) {
    final keyword = value.trim().toLowerCase();

    if (keyword.isEmpty) {
      // 👉 rỗng thì show full list
      _results = widget.banks;
    } else {
      _results = widget.banks.where((e) => e.toLowerCase().contains(keyword)).toList();
    }

    _updateOverlay();
  }

  void _handleFocusChange() {
    if (!_focusNode.hasFocus) {
      _hideOverlay();
    } else {
      // 👉 Khi vừa focus, show toàn bộ bank
      _results = widget.banks;
      _updateOverlay();
    }
  }

  void _updateOverlay() {
    if (_results.isEmpty || !_focusNode.hasFocus) {
      _hideOverlay();
      return;
    }

    _overlayEntry?.markNeedsBuild();
    if (_overlayEntry == null) {
      _overlayEntry = _buildOverlay();
      Overlay.of(context).insert(_overlayEntry!);
    }
  }

  OverlayEntry _buildOverlay() {
    final textTheme = Theme.of(context).textTheme;
    return OverlayEntry(
      builder: (context) {
        final renderBox = this.context.findRenderObject() as RenderBox?;
        final size = renderBox?.size ?? Size.zero;

        return Positioned(
          width: size.width,
          child: CompositedTransformFollower(
            link: _layerLink,
            offset: Offset(0, size.height + AppNumbers.DOUBLE_8),
            showWhenUnlinked: false,
            child: Material(
              elevation: AppNumbers.DOUBLE_4,
              borderRadius: BorderRadius.circular(AppNumbers.DOUBLE_12),
              child: Container(
                decoration: BoxDecoration(
                  color: AppColors.surface,
                  borderRadius: BorderRadius.circular(AppNumbers.DOUBLE_12),
                  border: Border.all(color: AppColors.border),
                ),
                child: ConstrainedBox(
                  constraints: const BoxConstraints(
                    maxHeight: 220, // ⭐ CHÌA KHOÁ
                  ),
                  child: ListView.separated(
                    padding: EdgeInsets.zero,
                    shrinkWrap: true,
                    itemCount: _results.length,
                    separatorBuilder: (context, index) => Divider(height: 1, color: AppColors.border),
                    itemBuilder: (context, index) {
                      final bank = _results[index];
                      return InkWell(
                        onTap: () {
                          _controller.text = bank;
                          widget.onSelected?.call(bank);
                          _hideOverlay();
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(AppNumbers.DOUBLE_12),
                          child: Text(bank, style: textTheme.titleSmall),
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
