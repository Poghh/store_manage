import 'package:flutter/material.dart';

import 'package:store_manage/core/widgets/app_empty_state.dart';

class TransactionEmptyState extends StatelessWidget {
  final String message;

  const TransactionEmptyState({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    return AppEmptyState(message: message);
  }
}
