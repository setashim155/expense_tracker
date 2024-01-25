import 'package:expense_tracker/constants/enums.dart';
import 'package:expense_tracker/constants/gaps.dart';
import 'package:expense_tracker/providers/common_providers.dart';
import 'package:expense_tracker/shared/helper.dart';
import 'package:expense_tracker/widgets/app_bar_chart.dart';
import 'package:expense_tracker/widgets/app_button.dart';
import 'package:expense_tracker/widgets/app_dropdown.dart';
import 'package:expense_tracker/widgets/app_line_chart.dart';
import 'package:expense_tracker/widgets/app_pie_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../constants/app_colors.dart';

class ChartPage extends ConsumerStatefulWidget {
  const ChartPage({super.key});

  @override
  ConsumerState createState() => _ChartPageState();
}

class _ChartPageState extends ConsumerState<ChartPage> {
  final _formKey = GlobalKey<FormBuilderState>();

  @override
  Widget build(BuildContext context) {
    final chartBuildStatus = ref.watch(chartBuildStatusProvider);

    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.bgColor1,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          foregroundColor: AppColors.textColor1,
          title: const Text('Chart'),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 16),
          child: ListView(
            children: [
              _buildChartOptions(),
              Gaps.vGap20,
              if (chartBuildStatus != null) _buildChart(),
              Gaps.vGap25,
              AppButton(
                labelText: 'GENERATE',
                onPressed: () {
                  // If fields are not valid
                  if (!_formKey.currentState!.saveAndValidate()) return;

                  // set status to true for generating the chart
                  ref.read(chartBuildStatusProvider.notifier).toggle();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// For chart options
  Widget _buildChartOptions() {
    return Consumer(
      builder: (context, ref, _) {
        final chartPeriod = ref.watch(chartPeriodNotifierProvider);

        return FormBuilder(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const AppDropdown(
                name: 'transactionType',
                labelText: 'Transaction Type',
                options: TransactionType.values,
              ),
              Gaps.vGap10,
              AppDropdown(
                name: 'chartPeriod',
                labelText: 'Chart Period',
                options: ChartPeriod.values,
                onItemSelected: (chartPeriod) => ref
                    .read(chartPeriodNotifierProvider.notifier)
                    .change(chartPeriod as ChartPeriod),
              ),
              Gaps.vGap10,
              if (chartPeriod != null)
                Row(
                  children: [
                    // Only for monthly
                    if (chartPeriod == ChartPeriod.monthly)
                      const Expanded(
                        child: Row(
                          children: [
                            Expanded(
                              child: AppDropdown(
                                name: 'month',
                                labelText: 'Month',
                                options: Month.values,
                              ),
                            ),
                            Gaps.hGap10,
                          ],
                        ),
                      ),
                    Expanded(
                      child: AppDropdown(
                        name: 'year',
                        labelText: 'Year',
                        options: Helper.generateYears(),
                      ),
                    ),
                  ],
                )
            ],
          ),
        );
      },
    );
  }

  /// For chart based on chart options
  Widget _buildChart() {
    final values = _formKey.currentState!.value;
    final transactionType = values['transactionType'] as TransactionType;
    final chartPeriod = values['chartPeriod'] as ChartPeriod;
    final year = values['year'] as String;

    if ((transactionType == TransactionType.income ||
            transactionType == TransactionType.expense) &&
        chartPeriod == ChartPeriod.monthly) {
      final month = values['month'] as Month;

      return AppPieChart(
          transactionType: transactionType, month: month, year: year);
    } else if ((transactionType == TransactionType.income ||
            transactionType == TransactionType.expense) &&
        chartPeriod == ChartPeriod.yearly) {
      return AppBarChart(transactionType: transactionType, year: year);
    } else if (transactionType == TransactionType.incomeAndExpense) {
      return AppLineChart(year: year);
    }

    return Container();
  }
}
