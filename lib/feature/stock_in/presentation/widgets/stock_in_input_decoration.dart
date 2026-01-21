import 'package:flutter/material.dart';

import 'package:store_manage/core/widgets/app_input_decoration.dart';

class StockInInputDecoration {
  static InputDecoration build({required String hintText, Widget? suffixIcon}) {
    return AppInputDecoration.build(hintText: hintText, suffixIcon: suffixIcon);
  }
}
