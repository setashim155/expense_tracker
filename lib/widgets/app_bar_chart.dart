import 'package:expense_tracker/constants/enums.dart';
import 'package:expense_tracker/providers/expense_providers.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../constants/app_colors.dart';
import '../providers/income_providers.dart';
import '../shared/helper.dart';
import 'error_view.dart';

class AppBarChart extends ConsumerWidget {
  final TransactionType transactionType;
  final String year;

  const AppBarChart({
    super.key,
    required this.transactionType,
    required this.year,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final AsyncValue<dynamic> dataState = (transactionType == TransactionType.income) ? ref.watch(allIncomesProvider) : ref.watch(allExpensesProvider);

    return dataState.when(
      data: (data) {
        final Map<dynamic, double> values = (transactionType == TransactionType.income)
            ? ref.read(incomeNotifierProvider.notifier).getYearlyAmounts(
                  incomes: data,
                  year: int.parse(year),
                )
            : ref.read(expenseNotifierProvider.notifier).getYearlyAmounts(
                  expenses: data,
                  year: int.parse(year),
                );

        return AspectRatio(
          aspectRatio: 1,
          child: BarChart(
            BarChartData(
              backgroundColor: AppColors.bgColor2,
              borderData: FlBorderData(
                border: const Border(
                  top: BorderSide.none,
                  right: BorderSide.none,
                  left: BorderSide(width: 1),
                  bottom: BorderSide(width: 1),
                ),
              ),
              groupsSpace: 4,
              barGroups: [
                for (final entry in values.entries)
                  BarChartGroupData(
                    x: entry.key.index + 1,
                    barRods: [
                      BarChartRodData(
                        toY: entry.value,
                        width: 16,
                        color: entry.key.color,
                      ),
                    ],
                  ),
              ],
              titlesData: FlTitlesData(
                topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),

                // For left side titles i.e. y-axis
                leftTitles: const AxisTitles(
                  axisNameWidget: Text(
                    'Amount (NPR, in K)',
                    style: TextStyle(
                      color: AppColors.textColor2,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  sideTitles: SideTitles(showTitles: false),
                ),

                // For bottom side titles i.e. x-axis
                bottomTitles: AxisTitles(
                  axisNameWidget: Text(
                    'Year: $year',
                    style: const TextStyle(
                      color: AppColors.textColor2,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  sideTitles: SideTitles(
                      showTitles: true,
                      interval: 2,
                      getTitlesWidget: (value, meta) {
                        String text = switch (value.toInt()) {
                          2 => 'Feb',
                          4 => 'Apr',
                          6 => 'Jun',
                          8 => 'Aug',
                          10 => 'Oct',
                          12 => 'Dec',
                          _ => '',
                        };

                        return Text(
                          text,
                          style: const TextStyle(color: AppColors.textColor2),
                        );
                      }),
                ),
              ),
            ),
          ),
        );
      },
      error: (error, _) => ErrorView(errorMsg: error.toString()),
      loading: () => const Center(child: CircularProgressIndicator()),
    );
  }
}
