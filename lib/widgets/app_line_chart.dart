import 'package:expense_tracker/providers/income_providers.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../constants/app_colors.dart';
import '../constants/enums.dart';
import '../providers/expense_providers.dart';
import 'error_view.dart';

class AppLineChart extends ConsumerWidget {
  final String year;

  const AppLineChart({
    super.key,
    required this.year,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final allIncomesState = ref.watch(allIncomesProvider);
    final allExpensesState = ref.watch(allExpensesProvider);

    return allIncomesState.when(
      data: (incomes) {
        return allExpensesState.when(
          data: (expenses) {
            final incomeValues = ref.read(incomeNotifierProvider.notifier).getYearlyAmounts(
                  incomes: incomes,
                  year: int.parse(year),
                );

            final expenseValues = ref.read(expenseNotifierProvider.notifier).getYearlyAmounts(
                  expenses: expenses,
                  year: int.parse(year),
                );

            return AspectRatio(
              aspectRatio: 1,
              child: LineChart(
                LineChartData(
                  backgroundColor: AppColors.bgColor2,
                  lineBarsData: [
                    // For income
                    LineChartBarData(
                      spots: [
                        for (final incomeValue in incomeValues.entries) FlSpot(incomeValue.key.index.toDouble(), incomeValue.value),
                      ],
                      isCurved: true,
                      color: Colors.green,
                    ),

                    // For expense
                    LineChartBarData(
                      spots: [
                        for (final expenseValue in expenseValues.entries) FlSpot(expenseValue.key.index.toDouble(), expenseValue.value),
                      ],
                      isCurved: true,
                      color: Colors.red,
                    ),
                  ],
                  titlesData: FlTitlesData(
                    topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                    rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),

                    // For left side titles i.e. y-axis
                    leftTitles: const AxisTitles(
                      axisNameWidget: Text(
                        'Amount (NPR)',
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
      },
      error: (error, _) => ErrorView(errorMsg: error.toString()),
      loading: () => const Center(child: CircularProgressIndicator()),
    );
  }
}
