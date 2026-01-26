import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
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
  late DateTime _selectedDate;
  bool _isFetching = false;
  late final RetailRevenueService _revenueService;
  late final ValueListenable _retailBoxListenable;

  @override
  void initState() {
    super.initState();
    _selectedDate = DateTime.now();
    // Debug: print current system time and selected date to help diagnose incorrect date issues
    debugPrint('HomeContent initState - DateTime.now(): ${DateTime.now().toIso8601String()}');
    debugPrint('HomeContent initState - timezone: ${DateTime.now().timeZoneName} ${DateTime.now().timeZoneOffset}');
    debugPrint('HomeContent initState - selectedDate init: ${_selectedDate.toIso8601String()}');
    _revenueService = di<RetailRevenueService>();
    _retailBoxListenable = _revenueService.listenable;
    _retailBoxListenable.addListener(_handleRetailChange);
    _loadApiData();
  }

  Future<void> _loadApiData() async {
    await _revenueService.loadApiData();
    if (mounted) setState(() {});
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

  Future<void> _changeDate(int daysDelta) async {
    if (_isFetching) return;
    final newDate = _selectedDate.add(Duration(days: daysDelta));
    if (newDate.isAfter(DateTime.now())) return;
    setState(() => _isFetching = true);
    await Future.delayed(const Duration(milliseconds: 200));
    if (!mounted) return;
    setState(() {
      _selectedDate = newDate;
      _isFetching = false;
    });
  }

  String _buildRevenueTitle() {
    final today = DateTime.now();
    if (CommonFuntionUtils.isSameDay(_selectedDate, today)) {
      return AppStrings.todayRevenueLabel;
    }
    final yesterday = today.subtract(const Duration(days: 1));
    if (CommonFuntionUtils.isSameDay(_selectedDate, yesterday)) {
      return AppStrings.homeRevenueYesterdayLabel;
    }
    return AppStrings.homeRevenueDateLabel(DateFormat('dd/MM/yyyy').format(_selectedDate));
  }

  void _openTransactionsForDate() {
    di<HomeTabCoordinator>().openTransactionsForDate(_selectedDate);
  }

  @override
  Widget build(BuildContext context) {
    final today = DateTime.now();
    final isToday = CommonFuntionUtils.isSameDay(_selectedDate, today);
    final dateText = DateFormat('dd/MM/yyyy').format(_selectedDate);
    final canPrev = !_isFetching;
    final canNext = !_isFetching && !isToday;
    final dateKey = DateFormat('yyyy-MM-dd').format(_selectedDate);
    final totalRevenue = _revenueService.getTotalRevenueForDate(dateKey);
    final revenueText = CommonFuntionUtils.formatCurrency(totalRevenue);
    final revenueTitle = _buildRevenueTitle();
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
                          onTap: () => _changeDate(-1),
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
                          onTap: () => _changeDate(1),
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
              onTap: _isFetching ? null : _openTransactionsForDate,
            ),
          ],
        ),
      ),
    );
  }
}
