import 'package:flutter/material.dart';

import 'package:store_manage/core/widgets/app_info_block.dart';

class TransactionInfoBlock extends StatelessWidget {
  final String label;
  final String value;

  const TransactionInfoBlock({super.key, required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: AppInfoBlock(label: label, value: value),
    );
  }
}
