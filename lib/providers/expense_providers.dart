import 'package:expense_tracker/models/expense.dart';
import 'package:expense_tracker/providers/service_providers.dart';
import 'package:expense_tracker/services/expense_service.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../constants/enums.dart';
import '../shared/helper.dart';

part 'expense_providers.g.dart';

@riverpod
Stream<List<Expense>> allExpenses(AllExpensesRef ref) {
  final expenseService = ref.read(expenseServiceProvider);

  return expenseService.getAllExpenses();
}

@riverpod
Stream<List<Expense>> recentExpenses(RecentExpensesRef ref) {
  final expenseService = ref.read(expenseServiceProvider);

  return expenseService.getRecentExpenses();
}

@riverpod
class ExpenseNotifier extends _$ExpenseNotifier {
  ExpenseService get _expenseService => ref.read(expenseServiceProvider);

  @override
  FutureOr<void> build() {}

  Future<void> createExpense({required Map<String, dynamic> values}) async {
    state = const AsyncLoading();

    state = await AsyncValue.guard(() => _expenseService.createExpense(values: values));
  }

  Future<void> updateExpense({
    required String id,
    required Map<String, dynamic> values,
  }) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() => _expenseService.updateExpense(id: id, values: values));
  }

  Future<void> deleteExpense({required String id}) async {
    state = const AsyncLoading();

    state = await AsyncValue.guard(() => _expenseService.deleteExpense(id: id));
  }

  /// Gets amounts for the given month of the year
  Map<ExpenseType, double> getMonthlyAmountsByType({
    required List<Expense> expenses,
    required int month,
    required int year,
  }) {
    final values = {
      for (final expenseType in ExpenseType.values) expenseType: 0.0,
    };

    for (final expense in expenses) {
      // Take amounts of only the given month and year
      if (!(Helper.isMonthSame(expense.date, month) && Helper.isYearSame(expense.date, year))) continue;

      values[expense.type] = values[expense.type]! + expense.amount;
    }

    return values;
  }

  /// Gets the amounts for the given year according to the month
  Map<Month, double> getYearlyAmounts({
    required List<Expense> expenses,
    required int year,
  }) {
    final values = {
      for (final month in Month.values) month: 0.0,
    };

    for (final expense in expenses) {
      // Take amounts of only the given year
      if (!Helper.isYearSame(expense.date, year)) continue;

      final month = Month.values[Helper.parseDate(expense.date).month - 1];
      values[month] = values[month]! + (expense.amount / 1000);
    }

    return values;
  }

  Future<void> exportAsPdf({
    required List<Expense> expenses,
    required double total,
  }) async {
    state = const AsyncLoading();

    state = await AsyncValue.guard(() => _expenseService.exportAsPdf(expenses: expenses, total: total));
  }

  Future<void> exportAsCsv({
    required List<Expense> expenses,
    required double total,
  }) async {
    state = const AsyncLoading();

    state = await AsyncValue.guard(() => _expenseService.exportAsCsv(expenses: expenses, total: total));
  }
}
