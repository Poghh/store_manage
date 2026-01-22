import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

import 'package:store_manage/core/constants/app_colors.dart';
import 'package:store_manage/core/constants/app_numbers.dart';
import 'package:store_manage/core/constants/app_strings.dart';
import 'package:store_manage/core/DI/di.dart';
import 'package:store_manage/core/navigation/home_tab_coordinator.dart';
import 'package:store_manage/core/services/retail_revenue_service.dart';
import 'package:store_manage/core/utils/common_funtion_utils.dart';
import 'package:store_manage/feature/home/presentation/widgets/revenue_summary_card.dart';

class HomeContent extends StatefulWidget {
  const HomeContent({super.key});

  @override
  State<HomeContent> createState() => _HomeContentState();
}

class _HomeContentState extends State<HomeContent> {
  final List<_RevenueRecord> _records = [];
  int _currentIndex = 0;
  bool _isFetching = false;
  late final RetailRevenueService _revenueService;
  late final ValueListenable _retailBoxListenable;

  @override
  void initState() {
    super.initState();
    _revenueService = di<RetailRevenueService>();
    _retailBoxListenable = _revenueService.listenable;
    _retailBoxListenable.addListener(_handleRetailChange);
    _loadRecords();
  }

  @override
  void dispose() {
    _retailBoxListenable.removeListener(_handleRetailChange);
    super.dispose();
  }

  void _handleRetailChange() {
    if (!mounted) return;
    setState(() {});
  }

  Future<void> _loadRecords() async {
    final raw = await rootBundle.loadString('assets/mocks/revenue.json');
    final json = jsonDecode(raw) as Map<String, dynamic>;
    final items = (json['records'] as List<dynamic>? ?? [])
        .whereType<Map<String, dynamic>>()
        .map(_RevenueRecord.fromJson)
        .toList();
    if (!mounted) return;
    setState(() {
      _records
        ..clear()
        ..addAll(items);
      _currentIndex = _pickTodayIndex();
    });
  }

  int _pickTodayIndex() {
    if (_records.isEmpty) return 0;
    final todayKey = DateFormat('yyyy-MM-dd').format(DateTime.now());
    final idx = _records.indexWhere((record) => record.rawDate == todayKey);
    return idx == -1 ? (_records.length - 1) : idx;
  }

  Future<void> _fetchRecord(int nextIndex) async {
    if (_isFetching || nextIndex == _currentIndex) return;
    setState(() => _isFetching = true);
    await Future.delayed(const Duration(milliseconds: 350));
    if (!mounted) return;
    setState(() {
      _currentIndex = nextIndex;
      _isFetching = false;
    });
  }

  _RevenueRecord? get _currentRecord => _records.isEmpty ? null : _records[_currentIndex.clamp(0, _records.length - 1)];

  String _buildRevenueTitle(_RevenueRecord? record) {
    if (record == null) return AppStrings.todayRevenueLabel;
    final parsed = DateTime.tryParse(record.rawDate);
    if (parsed == null) return AppStrings.todayRevenueLabel;
    final today = DateTime.now();
    if (CommonFuntionUtils.isSameDay(parsed, today)) {
      return AppStrings.todayRevenueLabel;
    }
    final yesterday = today.subtract(const Duration(days: 1));
    if (CommonFuntionUtils.isSameDay(parsed, yesterday)) {
      return AppStrings.homeRevenueYesterdayLabel;
    }
    return AppStrings.homeRevenueDateLabel(record.displayDate);
  }

  int _offlineRevenueForDate(String dateKey) => _revenueService.offlineRevenueForDate(dateKey);

  void _openTransactionsForRecord(_RevenueRecord? record) {
    final parsed = record == null ? null : DateTime.tryParse(record.rawDate);
    if (parsed == null) return;
    di<HomeTabCoordinator>().openTransactionsForDate(parsed);
  }

  @override
  Widget build(BuildContext context) {
    final record = _currentRecord;
    final parsedRecordDate = record == null ? null : DateTime.tryParse(record.rawDate);
    final isToday = parsedRecordDate != null && CommonFuntionUtils.isSameDay(parsedRecordDate, DateTime.now());
    final dateText = record == null ? '' : record.displayDate;
    final canPrev = !_isFetching && _currentIndex > 0;
    final canNext = !_isFetching && !isToday && _records.isNotEmpty && _currentIndex < _records.length - 1;
    final offlineRevenue = record == null ? 0 : _offlineRevenueForDate(record.rawDate);
    final revenueText = record == null ? '' : CommonFuntionUtils.formatCurrency(record.revenue + offlineRevenue);
    final revenueTitle = _buildRevenueTitle(record);
    return Container(
      color: AppColors.background,
      child: Padding(
        padding: const EdgeInsets.all(AppNumbers.DOUBLE_16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                RichText(
                  text: TextSpan(
                    style: Theme.of(context).textTheme.bodyMedium,
                    children: [
                      TextSpan(
                        text: AppStrings.homeGreetingPrefix,
                        style: TextStyle(color: AppColors.textSecondary),
                      ),
                      TextSpan(
                        text: AppStrings.homeGreetingName,
                        style: TextStyle(color: AppColors.textPrimary, fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: AppNumbers.DOUBLE_4),
                Row(
                  children: [
                    if (canPrev)
                      Material(
                        color: AppColors.surface.withValues(alpha: 0),
                        child: InkWell(
                          onTap: () => _fetchRecord(_currentIndex - 1),
                          borderRadius: BorderRadius.circular(AppNumbers.DOUBLE_16),
                          child: Icon(
                            Icons.arrow_circle_left,
                            size: AppNumbers.DOUBLE_16,
                            color: AppColors.textSecondary,
                          ),
                        ),
                      ),
                    if (canPrev) const SizedBox(width: AppNumbers.DOUBLE_4),
                    Text(
                      dateText,
                      style: Theme.of(context).textTheme.bodySmall!.copyWith(color: AppColors.textSecondary),
                    ),
                    if (canNext) const SizedBox(width: AppNumbers.DOUBLE_4),
                    if (canNext)
                      Material(
                        color: AppColors.surface.withValues(alpha: 0),
                        child: InkWell(
                          onTap: () => _fetchRecord(_currentIndex + 1),
                          borderRadius: BorderRadius.circular(AppNumbers.DOUBLE_16),
                          child: Icon(
                            Icons.arrow_circle_right,
                            size: AppNumbers.DOUBLE_16,
                            color: AppColors.textSecondary,
                          ),
                        ),
                      ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: AppNumbers.DOUBLE_16),
            RevenueSummaryCard(
              title: revenueTitle,
              revenueText: revenueText,
              isLoading: _isFetching,
              onTap: _isFetching ? null : () => _openTransactionsForRecord(record),
            ),
          ],
        ),
      ),
    );
  }
}

class _RevenueRecord {
  final String rawDate;
  final int revenue;

  _RevenueRecord({required this.rawDate, required this.revenue});

  factory _RevenueRecord.fromJson(Map<String, dynamic> json) => _RevenueRecord(
    rawDate: (json['date'] ?? '').toString(),
    revenue: (json['revenue'] is int) ? json['revenue'] as int : int.tryParse('${json['revenue']}') ?? 0,
  );

  String get displayDate {
    final parsed = DateTime.tryParse(rawDate);
    if (parsed == null) return rawDate;
    return DateFormat('dd/MM/yyyy').format(parsed);
  }
}
