import 'package:expense_tracker/constants/gaps.dart';
import 'package:expense_tracker/providers/filter_provider.dart';
import 'package:expense_tracker/providers/income_providers.dart';
import 'package:expense_tracker/shared/helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../constants/app_colors.dart';
import '../constants/enums.dart';
import '../models/income.dart';
import '../shared/router.dart';
import '../shared/ui_helper.dart';
import '../widgets/app_search_bar.dart';
import '../widgets/empty_view.dart';
import '../widgets/error_view.dart';
import '../widgets/item_tile.dart';

class IncomePage extends ConsumerStatefulWidget {
  const IncomePage({super.key});

  @override
  ConsumerState createState() => _IncomePageState();
}

class _IncomePageState extends ConsumerState<IncomePage> {
  List<Income> filteredIncomes = [];

  @override
  Widget build(BuildContext context) {
    // For income operations like CRUD, export, and so-on
    ref.listen(incomeNotifierProvider, (_, next) {
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
          title: const Text('Income'),
          actions: [
            // For export
            _buildPopupMenu(),

            // For clearing filter
            IconButton(
              onPressed: () => UiHelper.showAlert(
                context: context,
                title: 'Confirm Clear',
                message: 'Do you want to clear the filter?',
                onOk: () => ref
                    .read(filterProvider(id: TransactionType.income).notifier)
                    .clear(),
              ),
              icon: const Icon(Icons.filter_list_off_rounded),
            ),

            // For income form
            IconButton(
              onPressed: () => context.goNamed(AppRoute.incomeForm.name),
              icon: const Icon(Icons.add_rounded),
            ),

            // For filter page
            IconButton(
              onPressed: () => context.goNamed(AppRoute.filter.name,
                  extra: TransactionType.income),
              icon: const Icon(Icons.filter_list_rounded),
            ),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.only(top: 12),
          child: Column(
            children: [
              AppSearchBar(
                onSearch: (description) {
                  ref
                      .read(filterProvider(id: TransactionType.income).notifier)
                      .updateDescription(description);
                },
              ),
              _buildIncomeList(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildIncomeList() {
    return Consumer(
      builder: (context, ref, _) {
        final allIncomesState = ref.watch(allIncomesProvider);
        final _ = ref.watch(filterProvider(id: TransactionType.income));

        return allIncomesState.when(
          data: (incomes) {
            filteredIncomes = ref
                .read(filterProvider(id: TransactionType.income).notifier)
                .filter(data: incomes) as List<Income>;

            return filteredIncomes.isEmpty
                ? const EmptyView(message: 'Sorry, no incomes available.')
                : Expanded(
                    child: Column(
                      children: [
                        Expanded(
                          child: ListView.builder(
                            padding: const EdgeInsets.all(12),
                            itemCount: filteredIncomes.length,
                            itemBuilder: (context, index) {
                              final filteredIncome = filteredIncomes[index];

                              return ItemTile(
                                imageUrl: filteredIncome.type.iconPath,
                                description: filteredIncome.description,
                                date: filteredIncome.date,
                                amount: filteredIncome.amount,
                                onEdit: () => context.goNamed(
                                    AppRoute.incomeForm.name,
                                    extra: filteredIncome),
                                onDelete: () => UiHelper.showAlert(
                                  context: context,
                                  title: 'Confirm Delete',
                                  message: 'Do you want to remove this income?',
                                  onOk: () => ref
                                      .read(incomeNotifierProvider.notifier)
                                      .deleteIncome(id: filteredIncome.id),
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
                                Helper.formatCurrency(ref
                                    .read(filterProvider(
                                            id: TransactionType.income)
                                        .notifier)
                                    .total),
                                style: const TextStyle(
                                  color: Colors.green,
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
      final exportState = ref.watch(incomeNotifierProvider);

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
              onTap: () => ref
                  .read(incomeNotifierProvider.notifier)
                  .exportAsPdf(filteredIncomes),
              child: const Text('PDF'),
            ),
            PopupMenuItem(
              onTap: () => ref
                  .read(incomeNotifierProvider.notifier)
                  .exportAsCsv(filteredIncomes),
              child: const Text('CSV'),
            ),
          ];
        },
      );
    });
  }
}
