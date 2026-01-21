import 'package:flutter/material.dart';

import 'package:store_manage/core/widgets/app_info_row.dart';

class InfoRow extends StatelessWidget {
  final String label;
  final String value;

  const InfoRow({super.key, required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return AppInfoRow(label: label, value: value);
  }
}
