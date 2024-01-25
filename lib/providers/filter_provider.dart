import 'package:expense_tracker/models/filter_option.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../constants/enums.dart';
import '../shared/helper.dart';

part 'filter_provider.g.dart';

@riverpod
class Filter extends _$Filter {
  double total = 0;

  @override
  FilterOption build({required TransactionType id}) => const FilterOption();

  /// Updating the description of the filter option as provided
  void updateDescription(String description) {
    state = state.copyWith(description: description);
  }

  /// Updating the filter option as provided
  void update(Map<String, dynamic> values) {
    state = state.copyWith(
      fromDate: values['fromDate'],
      toDate: values['toDate'],
      type: values['type'],
      tag: values['tag'],
      filterCondition: values['filterCondition'],
      amount: values['amount'],
    );
  }

  /// For filtering the list with the given filter option
  List<dynamic> filter({required List<dynamic> data}) {
    // Resetting total
    total = 0;

    return data.where((data) {
      // For date wise
      if (state.fromDate.isNotEmpty && state.toDate.isNotEmpty) {
        DateTime fromDate = Helper.parseDate(state.fromDate);
        DateTime toDate = Helper.parseDate(state.toDate);
        DateTime date = Helper.parseDate(data.date);

        if (!(date.isAtSameMomentAs(fromDate) || date.isAfter(fromDate)) && (date.isAtSameMomentAs(toDate) || date.isBefore(toDate))) return false;
      }

      // For type wise
      if (state.type != null) {
        if (data.type != state.type) return false;
      }

      // For description wise
      if (state.description.isNotEmpty) {
        if (!(data.description.toLowerCase().contains(state.description.toLowerCase()))) return false;
      }

      // For tag wise
      if (state.tag != null) {
        if (data.tag != state.tag) return false;
      }

      // For amount wise
      if (state.filterCondition != null && state.amount.isNotEmpty) {
        final filterCondition = state.filterCondition!;
        final amount = double.parse(state.amount);

        if (!filterCondition.result(leftValue: data.amount, rightValue: amount)) return false;
      }

      // Calculate total
      total += data.amount as double;
      return true;
    }).toList();
  }

  /// For clearing all the filter options except the description
  void clear() => state = FilterOption(description: state.description);
}
