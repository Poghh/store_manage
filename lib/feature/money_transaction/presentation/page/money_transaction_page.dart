import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

import 'package:store_manage/core/constants/app_colors.dart';
import 'package:store_manage/core/constants/app_numbers.dart';
import 'package:store_manage/core/constants/app_strings.dart';
import 'package:store_manage/core/utils/common_funtion_utils.dart';
import 'package:store_manage/core/widgets/app_action_button.dart';
import 'package:store_manage/core/widgets/app_field_container.dart';
import 'package:store_manage/core/widgets/app_page_app_bar.dart';
import 'package:store_manage/core/widgets/app_pill.dart';
import 'package:store_manage/core/widgets/app_surface_card.dart';
import 'package:store_manage/feature/money_transaction/presentation/widget/bank_search_bar.dart';
import 'package:store_manage/feature/retail/presentation/widgets/retail_currency_input_formatter.dart';
import 'package:store_manage/feature/transactions/presentation/widgets/transaction_field_label.dart';

@RoutePage()
class MoneyTransactionPage extends StatefulWidget {
  const MoneyTransactionPage({super.key});

  @override
  State<MoneyTransactionPage> createState() => _MoneyTransactionPageState();
}

class _MoneyTransactionPageState extends State<MoneyTransactionPage> {
  TransactionType _transactionType = TransactionType.transfer;

  final TextEditingController _amountController = TextEditingController();
  final TextEditingController _bankController = TextEditingController();

  int _amount = 0;

  static const double _feeRate = 0.005;
  static const int _minFee = 5000;

  int get _fee {
    if (_amount <= 0) return 0;

    final calculatedFee = (_amount * _feeRate).round();
    return calculatedFee < _minFee ? _minFee : calculatedFee;
  }

  int get _total => _amount + _fee;

  final NumberFormat _currencyFormat = NumberFormat.decimalPattern(AppStrings.VIET_NAM_LOCALE);

  final List<String> _banks = const [
    'Vietcombank',
    'VietinBank',
    'BIDV',
    'Agribank',
    'Techcombank',
    'ACB',
    'MB Bank',
    'Sacombank',
    'VPBank',
    'SHB',
    'TPBank',
    'OCB',
  ];

  @override
  void dispose() {
    _amountController.dispose();
    _bankController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primary,
      appBar: AppPageAppBar(
        onBack: () => context.maybePop(),
        title: AppStrings.moneyTransactionTitle,
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: AppNumbers.DOUBLE_12),
            child: Icon(Icons.sync_alt, color: AppColors.textOnPrimary),
          ),
        ],
      ),
      body: SafeArea(
        bottom: false,
        child: SizedBox.expand(
          child: Container(
            decoration: const BoxDecoration(
              color: AppColors.background,
              borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
            ),
            padding: const EdgeInsets.all(AppNumbers.DOUBLE_16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildTransactionType(),
                const SizedBox(height: AppNumbers.DOUBLE_16),

                TransactionFieldLabel(text: AppStrings.amountLabel),
                const SizedBox(height: AppNumbers.DOUBLE_8),
                _buildAmountField(),
                const SizedBox(height: AppNumbers.DOUBLE_16),

                if (_transactionType == TransactionType.transfer) ...[
                  TransactionFieldLabel(text: AppStrings.bankLabel),
                  const SizedBox(height: AppNumbers.DOUBLE_8),
                  _buildBankField(),
                ],

                const SizedBox(height: AppNumbers.DOUBLE_24),
                _buildSummaryCards(),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: _buildConfirmButton(),
    );
  }

  // ===== OPTION CHUYỂN / RÚT =====
  Widget _buildTransactionType() {
    return Row(
      children: [
        GestureDetector(
          onTap: () => setState(() => _transactionType = TransactionType.transfer),
          child: AppPill(
            text: AppStrings.transferMoney,
            backgroundColor: _transactionType == TransactionType.transfer ? AppColors.primary : AppColors.primaryLight,
            textColor: _transactionType == TransactionType.transfer ? AppColors.textOnPrimary : AppColors.primary,
            padding: const EdgeInsets.symmetric(horizontal: AppNumbers.DOUBLE_16, vertical: AppNumbers.DOUBLE_8),
          ),
        ),
        const SizedBox(width: AppNumbers.DOUBLE_8),
        GestureDetector(
          onTap: () => setState(() => _transactionType = TransactionType.withdraw),
          child: AppPill(
            text: AppStrings.withdrawCash,
            backgroundColor: _transactionType == TransactionType.withdraw ? AppColors.primary : AppColors.primaryLight,
            textColor: _transactionType == TransactionType.withdraw ? AppColors.textOnPrimary : AppColors.primary,
            padding: const EdgeInsets.symmetric(horizontal: AppNumbers.DOUBLE_16, vertical: AppNumbers.DOUBLE_8),
          ),
        ),
      ],
    );
  }

  // ===== INPUT SỐ TIỀN (PRICE FIELD PATTERN) =====
  Widget _buildAmountField() {
    return AppFieldContainer(
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _amountController,
              keyboardType: TextInputType.number,
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
                RetailCurrencyInputFormatter(numberFormat: NumberFormat.decimalPattern(AppStrings.VIET_NAM_LOCALE)),
              ],
              decoration: const InputDecoration(
                border: InputBorder.none,
                isDense: true,
                hintText: AppStrings.amountHint,
                suffixText: AppStrings.VIET_NAM_DONG_TEXT,
              ),
              onChanged: (value) {
                final parsed = CommonFuntionUtils.parseDigitsToInt(value) ?? 0;
                setState(() => _amount = parsed);
              },
            ),
          ),
          const Icon(Icons.edit, color: AppColors.primary, size: AppNumbers.DOUBLE_18),
        ],
      ),
    );
  }

  // ===== AUTOCOMPLETE NGÂN HÀNG =====
  Widget _buildBankField() {
    return BankSearchBar(
      banks: _banks,
      onSelected: (value) {
        _bankController.text = value;
      },
    );
  }

  // ===== SUMMARY =====
  Widget _buildSummaryCards() {
    return Column(
      children: [
        AppSurfaceCard(child: _summaryRow(AppStrings.amountLabel, _format(_amount))),
        const SizedBox(height: AppNumbers.DOUBLE_8),
        AppSurfaceCard(child: _summaryRow(AppStrings.transactionFeeLabel, _format(_fee))),
        const SizedBox(height: AppNumbers.DOUBLE_8),
        AppSurfaceCard(child: _summaryRow(AppStrings.totalAmountLabel, _format(_total), isBold: true)),
      ],
    );
  }

  Widget _summaryRow(String label, String value, {bool isBold = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label),
        Text(value, style: TextStyle(fontWeight: isBold ? FontWeight.w700 : FontWeight.w400)),
      ],
    );
  }

  // ===== CONFIRM =====
  Widget _buildConfirmButton() {
    return Container(
      color: AppColors.background,
      child: SafeArea(
        top: false,
        child: Padding(
          padding: EdgeInsets.only(
            left: AppNumbers.DOUBLE_16,
            right: AppNumbers.DOUBLE_16,
            bottom: AppNumbers.DOUBLE_16 + MediaQuery.of(context).viewInsets.bottom,
          ),
          child: AppActionButton(label: AppStrings.confirmTransaction, onPressed: _amount > 0 ? _onConfirm : null),
        ),
      ),
    );
  }

  void _onConfirm() {
    //
  }

  String _format(int value) {
    if (value <= 0) return '0 đ';
    return '${_currencyFormat.format(value)} đ';
  }
}

enum TransactionType { transfer, withdraw }
