import 'package:flutter/material.dart';

class HomeTabCoordinator {
  final ValueNotifier<int?> requestedIndex = ValueNotifier<int?>(null);
  final ValueNotifier<DateTime?> selectedTransactionDate = ValueNotifier<DateTime?>(null);
  final ValueNotifier<int> inventoryRefreshTrigger = ValueNotifier<int>(0);

  void openTransactionsForDate(DateTime date) {
    selectedTransactionDate.value = date;
    requestedIndex.value = 1;
  }

  void triggerInventoryRefresh() {
    inventoryRefreshTrigger.value++;
  }
}
