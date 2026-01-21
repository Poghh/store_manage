import 'package:flutter/material.dart';

import 'package:store_manage/core/constants/app_colors.dart';
import 'package:store_manage/core/constants/app_font_sizes.dart';
import 'package:store_manage/core/constants/app_fonts.dart';
import 'package:store_manage/core/constants/app_numbers.dart';

class AppSearchField extends StatefulWidget {
  final TextEditingController controller;
  final FocusNode? focusNode;
  final String hintText;
  final ValueChanged<String>? onChanged;
  final FormFieldValidator<String>? validator;
  final AutovalidateMode? autovalidateMode;
  final Color iconColor;
  final IconData leadingIcon;
  final double leadingIconSize;
  final Widget? trailing;

  const AppSearchField({
    super.key,
    required this.controller,
    required this.hintText,
    this.focusNode,
    this.onChanged,
    this.validator,
    this.autovalidateMode,
    this.iconColor = AppColors.textSecondary,
    this.leadingIcon = Icons.search,
    this.leadingIconSize = AppNumbers.DOUBLE_20,
    this.trailing,
  });

  @override
  State<AppSearchField> createState() => _AppSearchFieldState();
}

class _AppSearchFieldState extends State<AppSearchField> {
  final GlobalKey<FormFieldState<String>> _fieldKey = GlobalKey<FormFieldState<String>>();
  bool _hasUserInput = false;

  @override
  void initState() {
    super.initState();
    widget.controller.addListener(_handleControllerChange);
  }

  @override
  void dispose() {
    widget.controller.removeListener(_handleControllerChange);
    super.dispose();
  }

  void _handleControllerChange() {
    final text = widget.controller.text;
    if (text.isNotEmpty) {
      _hasUserInput = true;
    }
    _fieldKey.currentState?.didChange(text);
  }

  @override
  Widget build(BuildContext context) {
    final effectiveAutovalidateMode = widget.autovalidateMode == AutovalidateMode.onUserInteraction
        ? (_hasUserInput ? AutovalidateMode.onUserInteraction : AutovalidateMode.disabled)
        : widget.autovalidateMode;

    return FormField<String>(
      key: _fieldKey,
      initialValue: widget.controller.text,
      validator: widget.validator,
      autovalidateMode: effectiveAutovalidateMode,
      builder: (state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: AppNumbers.DOUBLE_12, vertical: AppNumbers.DOUBLE_8),
              decoration: BoxDecoration(
                color: AppColors.surface,
                borderRadius: BorderRadius.circular(AppNumbers.DOUBLE_12),
                border: Border.all(color: state.hasError ? AppColors.error : AppColors.border),
              ),
              child: Row(
                children: [
                  Icon(widget.leadingIcon, size: widget.leadingIconSize, color: widget.iconColor),
                  const SizedBox(width: AppNumbers.DOUBLE_8),
                  Expanded(
                    child: TextField(
                      controller: widget.controller,
                      focusNode: widget.focusNode,
                      decoration: InputDecoration(hintText: widget.hintText, border: InputBorder.none, isDense: true),
                      style: const TextStyle(
                        fontSize: AppFontSizes.fontSize14,
                        fontWeight: FontWeight.w500,
                        color: AppColors.textPrimary,
                        fontFamily: AppFonts.inter,
                      ),
                      onChanged: (value) {
                        if (!_hasUserInput && value.isNotEmpty) {
                          setState(() => _hasUserInput = true);
                        }
                        state.didChange(value);
                        widget.onChanged?.call(value);
                      },
                    ),
                  ),
                  if (widget.trailing != null) widget.trailing!,
                ],
              ),
            ),
            if (state.hasError)
              Padding(
                padding: const EdgeInsets.only(top: AppNumbers.DOUBLE_6, left: AppNumbers.DOUBLE_8),
                child: Text(
                  state.errorText ?? '',
                  style: const TextStyle(
                    fontSize: AppFontSizes.fontSize12,
                    fontWeight: FontWeight.w500,
                    fontFamily: AppFonts.inter,
                    color: AppColors.error,
                  ),
                ),
              ),
          ],
        );
      },
    );
  }
}
