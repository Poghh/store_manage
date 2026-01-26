import 'package:flutter/material.dart';
import 'package:store_manage/core/DI/di.dart';
import 'package:store_manage/core/constants/app_colors.dart';
import 'package:store_manage/core/constants/app_numbers.dart';
import 'package:store_manage/core/constants/app_strings.dart';
import 'package:store_manage/core/services/retail_revenue_service.dart';
import 'package:store_manage/core/widgets/app_page_header.dart';
import 'package:store_manage/feature/reports/presentation/widgets/report_ai_insight_card.dart';
import 'package:store_manage/feature/reports/presentation/widgets/report_summary_card.dart';

class ReportsPage extends StatefulWidget {
  const ReportsPage({super.key});

  @override
  State<ReportsPage> createState() => _ReportsPageState();
}

class _ReportsPageState extends State<ReportsPage> {
  late final RetailRevenueService _revenueService;
  int _todayRevenue = 0;
  int _yesterdayRevenue = 0;
  double _growthPercentage = 0;

  @override
  void initState() {
    super.initState();
    _revenueService = di<RetailRevenueService>();
    _loadRevenueData();
  }

  Future<void> _loadRevenueData() async {
    await _revenueService.loadApiData();
    _todayRevenue = _revenueService.getTodayRevenue();
    _yesterdayRevenue = _revenueService.getYesterdayRevenue();
    _growthPercentage = _revenueService.calculateGrowthPercentage(_todayRevenue, _yesterdayRevenue);
    if (mounted) setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppPageHeader(title: AppStrings.homeTabReports),
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: ListView(
          padding: EdgeInsets.all(AppNumbers.DOUBLE_16),
          children: [
            ReportSummaryCard(
              todayRevenue: _todayRevenue,
              yesterdayRevenue: _yesterdayRevenue,
              growthPercentage: _growthPercentage,
            ),
            SizedBox(height: AppNumbers.DOUBLE_16),
            const ReportAiInsightCard(
              insights: [],
              suggestions: [],
            ),
          ],
        ),
      ),
    );
  }
}
