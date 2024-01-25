import 'package:expense_tracker/models/expense.dart';
import '../constants/enums.dart';
import 'package:expense_tracker/pages/chart_page.dart';
import 'package:expense_tracker/pages/dashboard_page.dart';
import 'package:expense_tracker/pages/filter_page.dart';
import 'package:expense_tracker/pages/income_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:go_router/go_router.dart';

import '../models/income.dart';
import '../pages/expense_form.dart';
import '../pages/expense_page.dart';
import '../pages/home_page.dart';
import '../pages/income_form.dart';
import '../pages/login_page.dart';
import '../pages/sign_up_page.dart';

enum AppRoute {
  login(name: 'login'),
  signUp(name: 'signUp'),
  dashboard(name: 'dashboard'),
  income(name: 'income'),
  expense(name: 'expense'),
  chart(name: 'chart'),
  incomeForm(name: 'incomeForm'),
  expenseForm(name: 'expenseForm'),
  filter(name: 'filter');

  final String name;

  const AppRoute({required this.name});
}

final router = GoRouter(
  redirect: (context, state) {
    final isLoggedIn = FirebaseAuth.instance.currentUser != null;
    final isLoginRoute = state.matchedLocation.contains('/login');

    if (!isLoggedIn && !isLoginRoute) {
      return '/login';
    } else if (isLoggedIn && isLoginRoute) {
      return '/';
    }

    return null;
  },
  routes: [
    // For login page
    GoRoute(
      name: AppRoute.login.name,
      path: '/login',
      builder: (context, state) => const LoginPage(),
      routes: [
        // For sign up page
        GoRoute(
          name: AppRoute.signUp.name,
          path: 'signUp',
          builder: (context, state) => const SignUpPage(),
        )
      ],
    ),

    // For home page
    StatefulShellRoute.indexedStack(
      builder: (context, state, navigationShell) => HomePage(navigationShell: navigationShell),
      branches: [
        // Dashboard page
        StatefulShellBranch(
          routes: [
            GoRoute(
              name: AppRoute.dashboard.name,
              path: '/',
              builder: (context, state) => const DashboardPage(),
            ),
          ],
        ),

        // Income page
        StatefulShellBranch(
          routes: [
            GoRoute(
              name: AppRoute.income.name,
              path: '/income',
              builder: (context, state) => const IncomePage(),
              routes: [
                // For income form
                GoRoute(
                  name: AppRoute.incomeForm.name,
                  path: 'incomeForm',
                  builder: (context, state) {
                    final income = state.extra != null ? state.extra as Income : null;

                    return IncomeForm(income: income);
                  },
                ),

                // For filter page
                GoRoute(
                  name: AppRoute.filter.name,
                  path: 'filter',
                  builder: (context, state) => FilterPage(filterType: state.extra as TransactionType),
                ),
              ],
            ),
          ],
        ),

        // Expense page
        StatefulShellBranch(
          routes: [
            GoRoute(
              name: AppRoute.expense.name,
              path: '/expense',
              builder: (context, state) => const ExpensePage(),
              routes: [
                // Expense form
                GoRoute(
                  name: AppRoute.expenseForm.name,
                  path: 'expenseForm',
                  builder: (context, state) {
                    final expense = state.extra != null ? state.extra as Expense : null;

                    return ExpenseForm(expense: expense);
                  },
                ),
              ],
            ),
          ],
        ),

        // Chart page
        StatefulShellBranch(
          routes: [
            GoRoute(
              name: AppRoute.chart.name,
              path: '/chart',
              builder: (context, state) => const ChartPage(),
            ),
          ],
        ),
      ],
    ),
  ],
);
