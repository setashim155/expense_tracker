import 'package:expense_tracker/constants/enums.dart';
import 'package:expense_tracker/constants/gaps.dart';
import 'package:expense_tracker/providers/expense_providers.dart';
import 'package:expense_tracker/providers/income_providers.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../constants/app_colors.dart';
import '../models/expense.dart';
import 'error_view.dart';

class AppPieChart extends ConsumerWidget {
  final TransactionType transactionType;
  final Month month;
  final String year;

  const AppPieChart({
    super.key,
    required this.transactionType,
    required this.month,
    required this.year,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final AsyncValue<dynamic> dataState = (transactionType == TransactionType.income) ? ref.watch(allIncomesProvider) : ref.watch(allExpensesProvider);

    return dataState.when(
      data: (data) {
        final Map<dynamic, double> values = (transactionType == TransactionType.income)
            ? ref.read(incomeNotifierProvider.notifier).getMonthlyAmountsByType(
                  incomes: data,
                  month: month.index + 1,
                  year: int.parse(year),
                )
            : ref.read(expenseNotifierProvider.notifier).getMonthlyAmountsByType(
                  expenses: data,
                  month: month.index + 1,
                  year: int.parse(year),
                );

        return Column(
          children: [
            AspectRatio(
              aspectRatio: 1,
              child: PieChart(
                PieChartData(
                  centerSpaceRadius: 70,
                  centerSpaceColor: AppColors.bgColor2,
                  sectionsSpace: 2,
                  sections: [
                    for (final entry in values.entries)
                      PieChartSectionData(
                        value: entry.value,
                        color: entry.key.color,
                        radius: 120,
                        showTitle: true,
                        title: entry.key.text,
                        titleStyle: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                  ],
                ),
              ),
            ),
            Text(
              '${month.text}, $year',
              style: const TextStyle(
                color: AppColors.textColor2,
                fontWeight: FontWeight.bold,
              ),
            )
          ],
        );
      },
      error: (error, _) => ErrorView(errorMsg: error.toString()),
      loading: () => const Center(child: CircularProgressIndicator()),
    );
  }
}
