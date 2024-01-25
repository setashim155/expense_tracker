import '../constants/enums.dart';
import 'package:expense_tracker/providers/expense_providers.dart';
import 'package:expense_tracker/providers/filter_provider.dart';
import 'package:expense_tracker/shared/router.dart';
import 'package:expense_tracker/widgets/app_search_bar.dart';
import 'package:expense_tracker/widgets/empty_view.dart';
import 'package:expense_tracker/widgets/error_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../constants/app_colors.dart';
import '../constants/gaps.dart';
import '../models/expense.dart';
import '../shared/helper.dart';
import '../shared/ui_helper.dart';
import '../widgets/item_tile.dart';

class ExpensePage extends ConsumerStatefulWidget {
  const ExpensePage({super.key});

  @override
  ConsumerState createState() => _ExpensePageState();
}

class _ExpensePageState extends ConsumerState<ExpensePage> {
  List<Expense> filteredExpenses = [];
  double total = 0;

  @override
  Widget build(BuildContext context) {
    // For creating, updating and deleting expense
    ref.listen(expenseNotifierProvider, (_, next) {
      // If loading
      if (next.isLoading) return;

      if (!next.hasError) {
        UiHelper.showSnackbar(
          context: context,
          message: next.value as String,
          type: SnackbarType.success,
        );
      } else {
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
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          foregroundColor: AppColors.textColor1,
          title: const Text('Expense'),
          actions: [
            // For export
            _buildPopupMenu(),

            // For clearing filter options
            IconButton(
              onPressed: () => UiHelper.showAlert(
                context: context,
                title: 'Confirm Clear',
                message: 'Do you want to clear the filter?',
                onOk: () => ref.read(filterProvider(id: TransactionType.expense).notifier).clear(),
              ),
              icon: const Icon(Icons.filter_list_off_rounded),
            ),

            // For expense form
            IconButton(
              onPressed: () => context.goNamed(AppRoute.expenseForm.name),
              icon: const Icon(Icons.add_rounded),
            ),

            // For filter page
            IconButton(
              onPressed: () => context.pushNamed(AppRoute.filter.name, extra: TransactionType.expense),
              icon: const Icon(Icons.filter_list_rounded),
            )
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.only(top: 12),
          child: Column(
            children: [
              // For search by description
              AppSearchBar(
                onSearch: (description) {
                  ref.read(filterProvider(id: TransactionType.expense).notifier).updateDescription(description);
                },
              ),
              _buildExpenseList(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildExpenseList() {
    return Consumer(
      builder: (context, ref, _) {
        final allExpensesState = ref.watch(allExpensesProvider);
        final _ = ref.watch(filterProvider(id: TransactionType.expense));

        return allExpensesState.when(
          data: (expenses) {
            filteredExpenses = ref.read(filterProvider(id: TransactionType.expense).notifier).filter(data: expenses) as List<Expense>;
            total = ref.read(filterProvider(id: TransactionType.expense).notifier).total;

            return filteredExpenses.isEmpty
                ? const EmptyView(message: 'Sorry, no expenses available.')
                : Expanded(
                    child: Column(
                      children: [
                        Expanded(
                          child: ListView.builder(
                            padding: const EdgeInsets.all(12),
                            itemCount: filteredExpenses.length,
                            itemBuilder: (context, index) {
                              final filteredExpense = filteredExpenses[index];

                              return ItemTile(
                                imageUrl: filteredExpense.type.iconPath,
                                description: filteredExpense.description,
                                date: filteredExpense.date,
                                amount: filteredExpense.amount,
                                onEdit: () => context.goNamed(AppRoute.expenseForm.name, extra: filteredExpense),
                                onDelete: () => UiHelper.showAlert(
                                  context: context,
                                  title: 'Confirm Delete',
                                  message: 'Do you want to remove this expense?',
                                  onOk: () => ref.read(expenseNotifierProvider.notifier).deleteExpense(id: filteredExpense.id),
                                ),
                              );
                            },
                          ),
                        ),
                        Gaps.vGap10,
                        Container(
                          width: double.infinity,
                          height: 52,
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          decoration: const BoxDecoration(
                            color: AppColors.bgColor2,
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(28),
                              topRight: Radius.circular(28),
                            ),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                'TOTAL:',
                                style: TextStyle(
                                  color: AppColors.textColor2,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                              Text(
                                Helper.formatCurrency(total),
                                style: const TextStyle(
                                  color: Colors.redAccent,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  );
          },
          error: (error, _) => ErrorView(errorMsg: error.toString()),
          loading: () => const Center(child: CircularProgressIndicator()),
        );
      },
    );
  }

  /// For export menu
  Widget _buildPopupMenu() {
    return Consumer(builder: (context, ref, _) {
      final exportState = ref.watch(expenseNotifierProvider);

      return PopupMenuButton(
        icon: exportState.isLoading
            ? const SizedBox(
                width: 24,
                height: 24,
                child: CircularProgressIndicator(
                  color: AppColors.textColor1,
                  strokeWidth: 2,
                ),
              )
            : const Icon(
                Icons.ios_share_rounded,
                color: AppColors.textColor1,
              ),
        itemBuilder: (context) {
          return [
            PopupMenuItem(
              onTap: () {
                ref.read(expenseNotifierProvider.notifier).exportAsPdf(
                      expenses: filteredExpenses,
                      total: total,
                    );
              },
              child: const Text('PDF'),
            ),
            PopupMenuItem(
              onTap: () {
                ref.read(expenseNotifierProvider.notifier).exportAsCsv(
                      expenses: filteredExpenses,
                      total: total,
                    );
              },
              child: const Text('CSV'),
            ),
          ];
        },
      );
    });
  }
}
