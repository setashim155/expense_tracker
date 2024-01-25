import 'package:expense_tracker/models/income.dart';
import 'package:expense_tracker/providers/income_providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../constants/app_colors.dart';
import '../constants/gaps.dart';
import '../constants/regex.dart';
import '../shared/ui_helper.dart';
import '../widgets/app_button.dart';
import '../widgets/app_date_picker.dart';
import '../widgets/app_dropdown.dart';
import '../widgets/app_text_field.dart';

class IncomeForm extends ConsumerStatefulWidget {
  final Income? income;

  const IncomeForm({
    super.key,
    this.income,
  });

  @override
  ConsumerState createState() => _IncomeFormState();
}

class _IncomeFormState extends ConsumerState<IncomeForm> {
  final _formKey = GlobalKey<FormBuilderState>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.bgColor1,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          foregroundColor: AppColors.textColor1,
          title: const Text('Income Form'),
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
                  initialValue: widget.income?.date,
                ),
                Gaps.vGap15,

                // Type
                AppDropdown(
                  name: 'type',
                  labelText: 'Type',
                  initialValue: widget.income?.type,
                  options: IncomeType.values,
                ),
                Gaps.vGap15,

                // Description
                AppTextField(
                  name: 'description',
                  labelText: 'Description',
                  initialValue: widget.income?.description,
                ),
                Gaps.vGap15,

                // Amount
                AppTextField(
                  name: 'amount',
                  labelText: 'Amount',
                  initialValue: widget.income?.amount.toString(),
                  regex: Regex.currency,
                ),
                Gaps.vGap60,
                Consumer(
                  builder: (context, ref, _) {
                    final incomeState = ref.watch(incomeNotifierProvider);

                    return AppButton(
                      labelText: 'SUBMIT',
                      isLoading: incomeState.isLoading,
                      onPressed: () {
                        // If fields are not valid
                        if (!_formKey.currentState!.saveAndValidate()) return;

                        UiHelper.showAlert(
                          context: context,
                          title: 'Confirm submit',
                          message: 'Are you sure you want to submit?',
                          onOk: () {
                            widget.income == null
                                ? ref.read(incomeNotifierProvider.notifier).createIncome(values: _formKey.currentState!.value)
                                : ref.read(incomeNotifierProvider.notifier).updateIncome(
                                      id: widget.income!.id,
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
