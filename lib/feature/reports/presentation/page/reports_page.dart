import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:store_manage/core/constants/app_colors.dart';
import 'package:store_manage/core/constants/app_numbers.dart';
import 'package:store_manage/core/constants/app_strings.dart';
import 'package:store_manage/core/widgets/app_page_header.dart';
import 'package:store_manage/feature/reports/presentation/widgets/report_ai_insight_card.dart';
import 'package:store_manage/feature/reports/presentation/widgets/report_summary_card.dart';

class ReportsPage extends StatefulWidget {
  const ReportsPage({super.key});

  @override
  State<ReportsPage> createState() => _ReportsPageState();
}

class _ReportsPageState extends State<ReportsPage> {
  bool _isLoading = true;
  _ReportData? _data;

  @override
  void initState() {
    super.initState();
    _loadReport();
  }

  Future<void> _loadReport() async {
    final raw = await rootBundle.loadString('assets/mocks/revenue_ai_report.json');
    final json = jsonDecode(raw) as Map<String, dynamic>;
    if (!mounted) return;
    setState(() {
      _data = _ReportData.fromJson(json);
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppPageHeader(title: AppStrings.homeTabReports),
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: _isLoading
            ? const Center(child: CircularProgressIndicator(color: AppColors.primary))
            : ListView(
                padding: const EdgeInsets.all(AppNumbers.DOUBLE_16),
                children: [
                  ReportSummaryCard(
                    date: _data!.date,
                    totalRevenue: _data!.totalRevenue,
                    growthValue: _data!.growthValue,
                    growthLabel: _data!.growthLabel,
                  ),
                  const SizedBox(height: AppNumbers.DOUBLE_16),
                  ReportAiInsightCard(insights: _data!.insights, suggestions: _data!.suggestions),
                ],
              ),
      ),
    );
  }
}

class _ReportData {
  final DateTime date;
  final int totalRevenue;
  final double growthValue;
  final String growthLabel;
  final List<String> insights;
  final List<String> suggestions;

  const _ReportData({
    required this.date,
    required this.totalRevenue,
    required this.growthValue,
    required this.growthLabel,
    required this.insights,
    required this.suggestions,
  });

  factory _ReportData.fromJson(Map<String, dynamic> json) {
    final dateText = (json['date'] ?? '').toString();
    final parsed = DateTime.tryParse(dateText) ?? DateTime.now();
    final growthValue = (json['growthValue'] is num)
        ? (json['growthValue'] as num).toDouble()
        : double.tryParse('${json['growthValue']}') ?? 0;
    return _ReportData(
      date: parsed,
      totalRevenue: (json['totalRevenue'] is int)
          ? json['totalRevenue'] as int
          : int.tryParse('${json['totalRevenue']}') ?? 0,
      growthValue: growthValue,
      growthLabel: (json['growthLabel'] ?? '').toString(),
      insights: (json['insights'] as List<dynamic>? ?? []).map((e) => e.toString()).toList(),
      suggestions: (json['suggestions'] as List<dynamic>? ?? []).map((e) => e.toString()).toList(),
    );
  }
}
