import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:store_manage/core/widgets/app_input_decoration.dart';

class AppTextFormField extends StatelessWidget {
  final TextEditingController? controller;
  final String? initialValue;
  final String? hintText;
  final bool enabled;
  final bool readOnly;
  final TextInputType? keyboardType;
  final AutovalidateMode? autovalidateMode;
  final FormFieldValidator<String>? validator;
  final List<TextInputFormatter>? inputFormatters;
  final VoidCallback? onTap;

  const AppTextFormField({
    super.key,
    this.controller,
    this.initialValue,
    this.hintText,
    this.enabled = true,
    this.readOnly = false,
    this.keyboardType,
    this.autovalidateMode,
    this.validator,
    this.inputFormatters,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      initialValue: controller == null ? initialValue : null,
      enabled: enabled,
      readOnly: readOnly,
      keyboardType: keyboardType,
      autovalidateMode: autovalidateMode,
      decoration: AppInputDecoration.build(hintText: hintText ?? ''),
      validator: validator,
      inputFormatters: inputFormatters,
      onTap: onTap,
    );
  }
}
