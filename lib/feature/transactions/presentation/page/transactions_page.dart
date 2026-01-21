import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

import 'package:store_manage/core/constants/app_colors.dart';
import 'package:store_manage/core/constants/app_font_sizes.dart';
import 'package:store_manage/core/constants/app_fonts.dart';
import 'package:store_manage/core/constants/app_numbers.dart';
import 'package:store_manage/core/constants/app_strings.dart';
import 'package:store_manage/core/DI/di.dart';
import 'package:store_manage/core/navigation/home_tab_coordinator.dart';
import 'package:store_manage/core/widgets/app_page_header.dart';
import 'package:store_manage/core/widgets/app_surface_card.dart';
import 'package:store_manage/feature/transactions/presentation/widgets/transaction_empty_state.dart';
import 'package:store_manage/feature/transactions/presentation/widgets/transaction_summary_card.dart';
import 'package:store_manage/feature/transactions/presentation/widgets/transactions_list.dart';

class TransactionsPage extends StatefulWidget {
  const TransactionsPage({super.key});

  @override
  State<TransactionsPage> createState() => _TransactionsPageState();
}

class _TransactionsPageState extends State<TransactionsPage> {
  bool _isLoading = false;
  DateTime? _selectedDate;
  List<_TransactionItem> _items = const [];
  late final HomeTabCoordinator _tabCoordinator;

  @override
  void initState() {
    super.initState();
    _tabCoordinator = di<HomeTabCoordinator>();
    _tabCoordinator.selectedTransactionDate.addListener(_handleDateSelected);
  }

  @override
  void dispose() {
    _tabCoordinator.selectedTransactionDate.removeListener(_handleDateSelected);
    super.dispose();
  }

  void _handleDateSelected() {
    final date = _tabCoordinator.selectedTransactionDate.value;
    if (date == null) return;
    _tabCoordinator.selectedTransactionDate.value = null;
    _setDate(date);
  }

  Future<void> _loadTransactions(DateTime date) async {
    setState(() => _isLoading = true);
    final raw = await rootBundle.loadString('assets/mocks/transactions.json');
    final json = jsonDecode(raw) as Map<String, dynamic>;
    final records = (json['records'] as List<dynamic>? ?? [])
        .whereType<Map<String, dynamic>>()
        .map(_TransactionRecord.fromJson)
        .toList();
    final dateKey = DateFormat('yyyy-MM-dd').format(date);
    final record = records.firstWhere(
      (item) => item.date == dateKey,
      orElse: () => const _TransactionRecord(date: '', items: []),
    );
    if (!mounted) return;
    setState(() {
      _items = record.items;
      _isLoading = false;
    });
  }

  Future<void> _pickDate() async {
    final now = DateTime.now();
    final picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? now,
      firstDate: DateTime(now.year - 1),
      lastDate: DateTime(now.year + 1),
    );
    if (picked == null) return;
    await _setDate(picked);
  }

  Future<void> _setDate(DateTime date) async {
    setState(() {
      _selectedDate = date;
      _items = const [];
    });
    await _loadTransactions(date);
  }

  @override
  Widget build(BuildContext context) {
    final dateDisplay = _selectedDate == null ? '' : DateFormat('dd/MM/yyyy').format(_selectedDate!);
    final totalRevenue = _items.fold<int>(0, (sum, item) => sum + item.total);
    return Scaffold(
      appBar: AppPageHeader(
        title: AppStrings.homeTabTransactions,
        actions: [
          TextButton.icon(
            onPressed: _pickDate,
            icon: const Icon(Icons.calendar_month, size: AppNumbers.DOUBLE_18),
            label: Text(
              dateDisplay.isEmpty ? AppStrings.transactionsSelectDate : dateDisplay,
              style: const TextStyle(
                fontSize: AppFontSizes.fontSize12,
                fontWeight: FontWeight.w600,
                fontFamily: AppFonts.inter,
              ),
            ),
          ),
          const SizedBox(width: AppNumbers.DOUBLE_8),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(AppNumbers.DOUBLE_16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: AppSurfaceCard(
                  padding: EdgeInsets.zero,
                  child: _selectedDate == null
                      ? const TransactionEmptyState(message: AppStrings.transactionsEmptySelectDate)
                      : _isLoading
                      ? const Center(child: CircularProgressIndicator(color: AppColors.primary))
                      : _items.isEmpty
                      ? const TransactionEmptyState(message: AppStrings.transactionsEmptyNoData)
                      : Column(
                          children: [
                            TransactionSummaryCard(totalRevenue: totalRevenue),
                            Expanded(
                              child: TransactionsList(
                                items: _items
                                    .map(
                                      (item) => (
                                        productCode: item.productCode,
                                        productName: item.productName,
                                        quantity: item.quantity,
                                        price: item.price,
                                        total: item.total,
                                        paymentMethod: item.paymentMethod,
                                      ),
                                    )
                                    .toList(),
                              ),
                            ),
                          ],
                        ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _TransactionRecord {
  final String date;
  final List<_TransactionItem> items;

  const _TransactionRecord({required this.date, required this.items});

  factory _TransactionRecord.fromJson(Map<String, dynamic> json) => _TransactionRecord(
    date: (json['date'] ?? '').toString(),
    items: (json['items'] as List<dynamic>? ?? [])
        .whereType<Map<String, dynamic>>()
        .map(_TransactionItem.fromJson)
        .toList(),
  );
}

class _TransactionItem {
  final String productCode;
  final String productName;
  final int quantity;
  final int price;
  final int total;
  final String paymentMethod;

  const _TransactionItem({
    required this.productCode,
    required this.productName,
    required this.quantity,
    required this.price,
    required this.total,
    required this.paymentMethod,
  });

  factory _TransactionItem.fromJson(Map<String, dynamic> json) => _TransactionItem(
    productCode: (json['productCode'] ?? '').toString(),
    productName: (json['productName'] ?? '').toString(),
    quantity: (json['quantity'] is int) ? json['quantity'] as int : int.tryParse('${json['quantity']}') ?? 0,
    price: (json['price'] is int) ? json['price'] as int : int.tryParse('${json['price']}') ?? 0,
    total: (json['total'] is int) ? json['total'] as int : int.tryParse('${json['total']}') ?? 0,
    paymentMethod: (json['paymentMethod'] ?? '').toString(),
  );
}
