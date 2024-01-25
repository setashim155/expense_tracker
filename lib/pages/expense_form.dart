import 'package:expense_tracker/providers/expense_providers.dart';
import 'package:expense_tracker/widgets/app_date_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../constants/app_colors.dart';
import '../constants/gaps.dart';
import '../constants/regex.dart';
import '../models/expense.dart';
import '../shared/ui_helper.dart';
import '../widgets/app_button.dart';
import '../widgets/app_dropdown.dart';
import '../widgets/app_text_field.dart';

class ExpenseForm extends ConsumerStatefulWidget {
  final Expense? expense;

  const ExpenseForm({
    super.key,
    this.expense,
  });

  @override
  ConsumerState createState() => _ExpenseFormState();
}

class _ExpenseFormState extends ConsumerState<ExpenseForm> {
  final _formKey = GlobalKey<FormBuilderState>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.bgColor1,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          foregroundColor: AppColors.textColor1,
          title: const Text('Expense Form'),
        ),
        body: _buildForm(),
      ),
    );
  }

  Widget _buildForm() {
    return FormBuilder(
      key: _formKey,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: SizedBox(
          width: double.infinity,
          height: double.infinity,
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                // Date
                AppDatePicker(
                  name: 'date',
                  labelText: 'Date',
                  initialValue: widget.expense?.date,
                ),
                Gaps.vGap15,

                // Type
                AppDropdown(
                  name: 'type',
                  labelText: 'Type',
                  initialValue: widget.expense?.type,
                  options: ExpenseType.values,
                ),
                Gaps.vGap15,

                // Description
                AppTextField(
                  name: 'description',
                  labelText: 'Description',
                  initialValue: widget.expense?.description,
                ),
                Gaps.vGap15,

                // Tag
                AppDropdown(
                  name: 'tag',
                  labelText: 'Tag',
                  initialValue: widget.expense?.tag,
                  options: ExpenseTag.values,
                ),
                Gaps.vGap15,

                // Amount
                AppTextField(
                  name: 'amount',
                  labelText: 'Amount',
                  initialValue: widget.expense?.amount.toString(),
                  regex: Regex.currency,
                ),
                Gaps.vGap60,
                Consumer(
                  builder: (context, ref, _) {
                    final expenseState = ref.watch(expenseNotifierProvider);

                    return AppButton(
                      labelText: 'SUBMIT',
                      isLoading: expenseState.isLoading,
                      onPressed: () {
                        FocusScope.of(context).unfocus();

                        // If fields are not valid
                        if (!_formKey.currentState!.saveAndValidate()) return;

                        UiHelper.showAlert(
                          context: context,
                          title: 'Confirm submit',
                          message: 'Are you sure you want to submit?',
                          onOk: () {
                            widget.expense == null
                                ? ref.read(expenseNotifierProvider.notifier).createExpense(values: _formKey.currentState!.value)
                                : ref.read(expenseNotifierProvider.notifier).updateExpense(
                                      id: widget.expense!.id,
                                      values: _formKey.currentState!.value,
                                    );
                          },
                        );
                      },
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
