import 'package:expense_tracker/models/income.dart';
import 'package:expense_tracker/providers/filter_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../constants/enums.dart';
import '../constants/app_colors.dart';
import '../constants/gaps.dart';
import '../constants/regex.dart';
import '../models/expense.dart';
import '../models/filter_option.dart';
import '../widgets/app_button.dart';
import '../widgets/app_date_picker.dart';
import '../widgets/app_dropdown.dart';
import '../widgets/app_text_field.dart';

class FilterPage extends ConsumerStatefulWidget {
  final TransactionType filterType;

  const FilterPage({
    super.key,
    required this.filterType,
  });

  @override
  ConsumerState createState() => _FilterPageState();
}

class _FilterPageState extends ConsumerState<FilterPage> {
  final _formKey = GlobalKey<FormBuilderState>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.bgColor1,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          foregroundColor: AppColors.textColor1,
          title: const Text('Filter Options'),
        ),
        body: _buildOptionList(), // For filter options
      ),
    );
  }

  Widget _buildOptionList() {
    final filterOption = ref.read(filterProvider(id: widget.filterType));

    return FormBuilder(
      key: _formKey,
      child: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          // Filter by date
          const Text(
            'By Date',
            style: TextStyle(
              color: AppColors.textColor2,
              fontWeight: FontWeight.bold,
              fontSize: 14,
            ),
          ),
          Gaps.vGap15,

          // From date
          AppDatePicker(
            name: 'fromDate',
            labelText: 'From',
            initialValue: filterOption.fromDate,
            isRequired: false,
          ),
          Gaps.vGap10,

          // To date
          AppDatePicker(
            name: 'toDate',
            labelText: 'To',
            initialValue: filterOption.toDate,
            isRequired: false,
          ),
          Gaps.vGap10,

          const Divider(color: AppColors.bgColor2, thickness: 2),
          Gaps.vGap10,

          // Filter by type
          const Text(
            'By Type',
            style: TextStyle(
              color: AppColors.textColor2,
              fontWeight: FontWeight.bold,
              fontSize: 14,
            ),
          ),
          Gaps.vGap15,

          // Type
          AppDropdown(
            name: 'type',
            labelText: 'Type',
            options: widget.filterType == TransactionType.income ? IncomeType.values : ExpenseType.values,
            initialValue: filterOption.type,
            isRequired: false,
          ),
          Gaps.vGap10,
          const Divider(color: AppColors.bgColor2, thickness: 2),
          Gaps.vGap10,

          // Filter by tag only for expense
          if (widget.filterType == TransactionType.expense)
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'By Tag',
                  style: TextStyle(
                    color: AppColors.textColor2,
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),

                Gaps.vGap15,

                // Tag
                AppDropdown(
                  name: 'tag',
                  labelText: 'Tag',
                  initialValue: filterOption.tag,
                  options: ExpenseTag.values,
                  isRequired: false,
                ),
                Gaps.vGap10,
                const Divider(color: AppColors.bgColor2, thickness: 2),
                Gaps.vGap10,
              ],
            ),

          // Filter by amount
          const Text(
            'By Amount',
            style: TextStyle(
              color: AppColors.textColor2,
              fontWeight: FontWeight.bold,
              fontSize: 14,
            ),
          ),
          Gaps.vGap15,

          // Conditions
          AppDropdown(
            name: 'filterCondition',
            labelText: 'Filter Condition',
            initialValue: filterOption.filterCondition,
            options: FilterCondition.values,
            isRequired: false,
          ),
          Gaps.vGap15,

          // Amount
          AppTextField(
            name: 'amount',
            labelText: 'Amount',
            initialValue: filterOption.amount,
            regex: Regex.currency,
            isRequired: false,
          ),
          Gaps.vGap30,

          // Filter button
          AppButton(
            labelText: 'FILTER',
            onPressed: () {
              FocusScope.of(context).unfocus();

              // Return if not valid
              if (!_formKey.currentState!.saveAndValidate()) {
                return;
              }

              //If valid
              // Updating the filter option
              ref.read(filterProvider(id: widget.filterType).notifier).update(_formKey.currentState!.value);

              context.pop();
            },
          ),
        ],
      ),
    );
  }
}
