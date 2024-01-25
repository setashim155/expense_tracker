import 'package:freezed_annotation/freezed_annotation.dart';

part 'filter_option.freezed.dart';

// For filter
enum FilterCondition {
  isEqualTo(text: '='),
  isNotEqualTo(text: '≠'),
  isLessThan(text: '<'),
  isLessThanOrEqualTo(text: '<='),
  isGreaterThan(text: '>'),
  isGreaterThanOrEqualTo(text: '>=');

  final String text;

  const FilterCondition({required this.text});

  bool result({
    required double leftValue,
    required double rightValue,
  }) {
    return switch (this) {
      isEqualTo => leftValue == rightValue,
      isNotEqualTo => leftValue != rightValue,
      isLessThan => leftValue < rightValue,
      isLessThanOrEqualTo => leftValue <= rightValue,
      isGreaterThan => leftValue > rightValue,
      isGreaterThanOrEqualTo => leftValue >= rightValue,
    };
  }
}

@freezed
class FilterOption with _$FilterOption {
  const factory FilterOption({
    @Default('') String fromDate,
    @Default('') String toDate,
    dynamic type,
    @Default('') String description,
    dynamic tag,
    FilterCondition? filterCondition,
    @Default('') String amount,
  }) = _FilterOption;
}
