import 'package:expense_tracker/services/expense_service.dart';
import 'package:expense_tracker/services/income_service.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../services/auth_service.dart';

part 'service_providers.g.dart';

@Riverpod(keepAlive: true)
AuthService authService(AuthServiceRef ref) => AuthService();

@Riverpod(keepAlive: true)
IncomeService incomeService(IncomeServiceRef ref) => IncomeService();

@Riverpod(keepAlive: true)
ExpenseService expenseService(ExpenseServiceRef ref) => ExpenseService();
