import 'package:flutter/material.dart';

class HomeTabCoordinator {
  final ValueNotifier<int?> requestedIndex = ValueNotifier<int?>(null);
  final ValueNotifier<DateTime?> selectedTransactionDate = ValueNotifier<DateTime?>(null);

  void openTransactionsForDate(DateTime date) {
    selectedTransactionDate.value = date;
    requestedIndex.value = 1;
  }
}
