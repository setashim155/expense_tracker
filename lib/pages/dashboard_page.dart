import 'package:expense_tracker/constants/app_colors.dart';
import 'package:expense_tracker/constants/gaps.dart';
import 'package:expense_tracker/providers/auth_providers.dart';
import 'package:expense_tracker/providers/expense_providers.dart';
import 'package:expense_tracker/providers/income_providers.dart';
import 'package:expense_tracker/shared/router.dart';
import 'package:expense_tracker/shared/ui_helper.dart';
import 'package:expense_tracker/widgets/circular_image.dart';
import 'package:expense_tracker/widgets/error_view.dart';
import 'package:expense_tracker/widgets/item_tile.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class DashboardPage extends ConsumerStatefulWidget {
  const DashboardPage({super.key});

  @override
  ConsumerState createState() => _DashboardPageState();
}

class _DashboardPageState extends ConsumerState<DashboardPage> {
  final currentUser = FirebaseAuth.instance.currentUser!;

  @override
  Widget build(BuildContext context) {
    // For logout
    ref.listen(authProvider, (previous, next) {
      if (next.isLoading) return;

      if (next.hasError) {
        UiHelper.showSnackbar(
          context: context,
          message: next.error.toString(),
          type: SnackbarType.error,
        );
      }
    });

    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.bgColor1,
        body: Container(
          padding: const EdgeInsets.all(20),
          width: double.infinity,
          height: double.infinity,
          child: Column(
            children: [
              _buildTitleSection(),
              Gaps.vGap20,
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      // For recent incomes
                      SizedBox(
                        height: 32,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              'Recent Incomes',
                              style: TextStyle(
                                color: AppColors.textColor2,
                              ),
                            ),
                            TextButton(
                              onPressed: () =>
                                  context.goNamed(AppRoute.income.name),
                              child: const Text(
                                'See more',
                                style: TextStyle(
                                  color: AppColors.textColor2,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      _buildRecentIncomesList(),

                      Gaps.vGap30,

                      // For recent expenses
                      SizedBox(
                        height: 32,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              'Recent Expenses',
                              style: TextStyle(
                                color: AppColors.textColor2,
                              ),
                            ),
                            TextButton(
                              onPressed: () =>
                                  context.goNamed(AppRoute.expense.name),
                              child: const Text(
                                'See more',
                                style: TextStyle(
                                  color: AppColors.textColor2,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      _buildRecentExpensesList(),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTitleSection() {
    return SizedBox(
      height: 66,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              CircularImage(
                imageUrl: currentUser.photoURL!,
                outerRadius: 30,
                innerRadius: 28,
              ),
              Gaps.hGap10,
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Welcome,',
                    style: TextStyle(
                      color: AppColors.textColor2,
                      fontSize: 16,
                    ),
                  ),
                  Text(
                    currentUser.displayName!,
                    style: const TextStyle(
                      color: AppColors.textColor1,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ],
          ),
          IconButton(
            onPressed: () {
              UiHelper.showAlert(
                context: context,
                title: 'Confirm Logout',
                message: 'Do you want to logout?',
                onOk: () => ref.read(authProvider.notifier).logout(),
              );
            },
            icon: const Icon(
              Icons.logout_rounded,
              color: AppColors.textColor1,
              size: 28,
            ),
          ),
        ],
      ),
    );
  }

  /// For recent incomes
  Widget _buildRecentIncomesList() {
    return Consumer(
      builder: (context, ref, _) {
        final recentIncomesState = ref.watch(recentIncomesProvider);

        return recentIncomesState.when(
          data: (recentIncomes) => recentIncomes.isEmpty
              ? const Center(
                  child: Text(
                    'Sorry, no recent incomes.',
                    style: TextStyle(color: AppColors.textColor2),
                  ),
                )
              : SizedBox(
                  height: 300,
                  child: ListView.builder(
                    itemCount: recentIncomes.length,
                    itemBuilder: (context, index) {
                      final recentIncome = recentIncomes[index];

                      return ItemTile(
                        imageUrl: recentIncome.type.iconPath,
                        description: recentIncome.description,
                        date: recentIncome.date,
                        amount: recentIncome.amount,
                        onEdit: () => context.goNamed(AppRoute.expenseForm.name,
                            extra: recentIncome),
                        onDelete: () => UiHelper.showAlert(
                          context: context,
                          title: 'Confirm Delete',
                          message: 'Do you want to remove this income?',
                          onOk: () => ref
                              .read(incomeNotifierProvider.notifier)
                              .deleteIncome(id: recentIncome.id),
                        ),
                      );
                    },
                  ),
                ),
          error: (error, _) => ErrorView(errorMsg: error.toString()),
          loading: () => const Center(child: CircularProgressIndicator()),
        );
      },
    );
  }

  /// For recent expenses
  Widget _buildRecentExpensesList() {
    return Consumer(
      builder: (context, ref, _) {
        final recentExpensesState = ref.watch(recentExpensesProvider);

        return recentExpensesState.when(
          data: (recentExpenses) => recentExpenses.isEmpty
              ? const Center(
                  child: Text(
                    'Sorry, no recent expenses.',
                    style: TextStyle(color: AppColors.textColor2),
                  ),
                )
              : SizedBox(
                  height: 300,
                  child: ListView.builder(
                    itemCount: recentExpenses.length,
                    itemBuilder: (context, index) {
                      final recentExpense = recentExpenses[index];

                      return ItemTile(
                        imageUrl: recentExpense.type.iconPath,
                        description: recentExpense.description,
                        date: recentExpense.date,
                        amount: recentExpense.amount,
                        onEdit: () => context.goNamed(AppRoute.expenseForm.name,
                            extra: recentExpense),
                        onDelete: () => UiHelper.showAlert(
                          context: context,
                          title: 'Confirm Delete',
                          message: 'Do you want to remove this expense?',
                          onOk: () => ref
                              .read(expenseNotifierProvider.notifier)
                              .deleteExpense(id: recentExpense.id),
                        ),
                      );
                    },
                  ),
                ),
          error: (error, _) => ErrorView(errorMsg: error.toString()),
          loading: () => const Center(child: CircularProgressIndicator()),
        );
      },
    );
  }
}
