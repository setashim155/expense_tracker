import 'package:expense_tracker/models/income.dart';
import 'package:expense_tracker/providers/service_providers.dart';
import 'package:expense_tracker/services/income_service.dart';
import 'package:expense_tracker/shared/helper.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../constants/enums.dart';

part 'income_providers.g.dart';

@riverpod
Stream<List<Income>> allIncomes(AllIncomesRef ref) {
  final incomeService = ref.read(incomeServiceProvider);

  return incomeService.getAllIncomes();
}

@riverpod
Stream<List<Income>> recentIncomes(RecentIncomesRef ref) {
  final incomeService = ref.read(incomeServiceProvider);

  return incomeService.getRecentIncomes();
}

@riverpod
class IncomeNotifier extends _$IncomeNotifier {
  IncomeService get _incomeService => ref.read(incomeServiceProvider);

  @override
  FutureOr<void> build() {}

  Future<void> createIncome({required Map<String, dynamic> values}) async {
    state = const AsyncLoading();

    state = await AsyncValue.guard(() => _incomeService.createIncome(values: values));
  }

  Future<void> updateIncome({
    required String id,
    required Map<String, dynamic> values,
  }) async {
    state = const AsyncLoading();

    state = await AsyncValue.guard(() => _incomeService.updateIncome(id: id, values: values));
  }

  Future<void> deleteIncome({required String id}) async {
    state = const AsyncLoading();

    state = await AsyncValue.guard(() => _incomeService.deleteIncome(id: id));
  }

  /// Gets amounts for the given month of the year
  Map<IncomeType, double> getMonthlyAmountsByType({
    required List<Income> incomes,
    required int month,
    required int year,
  }) {
    final values = {
      for (final incomeType in IncomeType.values) incomeType: 0.0,
    };

    for (final income in incomes) {
      // Take amounts of only the given month and year
      if (!(Helper.isMonthSame(income.date, month) && Helper.isYearSame(income.date, year))) continue;

      values[income.type] = values[income.type]! + income.amount;
    }

    return values;
  }

  /// Gets the amounts for the given year according to the month
  Map<Month, double> getYearlyAmounts({
    required List<Income> incomes,
    required int year,
  }) {
    final values = {
      for (final month in Month.values) month: 0.0,
    };

    for (final income in incomes) {
      // Take amounts of only the given year
      if (!Helper.isYearSame(income.date, year)) continue;

      final month = Month.values[Helper.parseDate(income.date).month - 1];
      values[month] = values[month]! + (income.amount / 1000);
    }

    return values;
  }

  /// For exporting the incomes as pdf documents for printing
  Future<void> exportAsPdf(List<Income> incomes) async {
    state = const AsyncLoading();

    state = await AsyncValue.guard(() => _incomeService.exportAsPdf(incomes));
  }

  /// For exporting the incomes as csv file
  Future<void> exportAsCsv(List<Income> incomes) async {
    state = const AsyncLoading();

    state = await AsyncValue.guard(() => _incomeService.exportAsCsv(incomes));
  }
}
