// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'filter_option.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$FilterOption {
  String get fromDate => throw _privateConstructorUsedError;
  String get toDate => throw _privateConstructorUsedError;
  dynamic get type => throw _privateConstructorUsedError;
  String get description => throw _privateConstructorUsedError;
  dynamic get tag => throw _privateConstructorUsedError;
  FilterCondition? get filterCondition => throw _privateConstructorUsedError;
  String get amount => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $FilterOptionCopyWith<FilterOption> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $FilterOptionCopyWith<$Res> {
  factory $FilterOptionCopyWith(
          FilterOption value, $Res Function(FilterOption) then) =
      _$FilterOptionCopyWithImpl<$Res, FilterOption>;
  @useResult
  $Res call(
      {String fromDate,
      String toDate,
      dynamic type,
      String description,
      dynamic tag,
      FilterCondition? filterCondition,
      String amount});
}

/// @nodoc
class _$FilterOptionCopyWithImpl<$Res, $Val extends FilterOption>
    implements $FilterOptionCopyWith<$Res> {
  _$FilterOptionCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? fromDate = null,
    Object? toDate = null,
    Object? type = freezed,
    Object? description = null,
    Object? tag = freezed,
    Object? filterCondition = freezed,
    Object? amount = null,
  }) {
    return _then(_value.copyWith(
      fromDate: null == fromDate
          ? _value.fromDate
          : fromDate // ignore: cast_nullable_to_non_nullable
              as String,
      toDate: null == toDate
          ? _value.toDate
          : toDate // ignore: cast_nullable_to_non_nullable
              as String,
      type: freezed == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as dynamic,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      tag: freezed == tag
          ? _value.tag
          : tag // ignore: cast_nullable_to_non_nullable
              as dynamic,
      filterCondition: freezed == filterCondition
          ? _value.filterCondition
          : filterCondition // ignore: cast_nullable_to_non_nullable
              as FilterCondition?,
      amount: null == amount
          ? _value.amount
          : amount // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$FilterOptionImplCopyWith<$Res>
    implements $FilterOptionCopyWith<$Res> {
  factory _$$FilterOptionImplCopyWith(
          _$FilterOptionImpl value, $Res Function(_$FilterOptionImpl) then) =
      __$$FilterOptionImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String fromDate,
      String toDate,
      dynamic type,
      String description,
      dynamic tag,
      FilterCondition? filterCondition,
      String amount});
}

/// @nodoc
class __$$FilterOptionImplCopyWithImpl<$Res>
    extends _$FilterOptionCopyWithImpl<$Res, _$FilterOptionImpl>
    implements _$$FilterOptionImplCopyWith<$Res> {
  __$$FilterOptionImplCopyWithImpl(
      _$FilterOptionImpl _value, $Res Function(_$FilterOptionImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? fromDate = null,
    Object? toDate = null,
    Object? type = freezed,
    Object? description = null,
    Object? tag = freezed,
    Object? filterCondition = freezed,
    Object? amount = null,
  }) {
    return _then(_$FilterOptionImpl(
      fromDate: null == fromDate
          ? _value.fromDate
          : fromDate // ignore: cast_nullable_to_non_nullable
              as String,
      toDate: null == toDate
          ? _value.toDate
          : toDate // ignore: cast_nullable_to_non_nullable
              as String,
      type: freezed == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as dynamic,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      tag: freezed == tag
          ? _value.tag
          : tag // ignore: cast_nullable_to_non_nullable
              as dynamic,
      filterCondition: freezed == filterCondition
          ? _value.filterCondition
          : filterCondition // ignore: cast_nullable_to_non_nullable
              as FilterCondition?,
      amount: null == amount
          ? _value.amount
          : amount // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$FilterOptionImpl implements _FilterOption {
  const _$FilterOptionImpl(
      {this.fromDate = '',
      this.toDate = '',
      this.type,
      this.description = '',
      this.tag,
      this.filterCondition,
      this.amount = ''});

  @override
  @JsonKey()
  final String fromDate;
  @override
  @JsonKey()
  final String toDate;
  @override
  final dynamic type;
  @override
  @JsonKey()
  final String description;
  @override
  final dynamic tag;
  @override
  final FilterCondition? filterCondition;
  @override
  @JsonKey()
  final String amount;

  @override
  String toString() {
    return 'FilterOption(fromDate: $fromDate, toDate: $toDate, type: $type, description: $description, tag: $tag, filterCondition: $filterCondition, amount: $amount)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$FilterOptionImpl &&
            (identical(other.fromDate, fromDate) ||
                other.fromDate == fromDate) &&
            (identical(other.toDate, toDate) || other.toDate == toDate) &&
            const DeepCollectionEquality().equals(other.type, type) &&
            (identical(other.description, description) ||
                other.description == description) &&
            const DeepCollectionEquality().equals(other.tag, tag) &&
            (identical(other.filterCondition, filterCondition) ||
                other.filterCondition == filterCondition) &&
            (identical(other.amount, amount) || other.amount == amount));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      fromDate,
      toDate,
      const DeepCollectionEquality().hash(type),
      description,
      const DeepCollectionEquality().hash(tag),
      filterCondition,
      amount);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$FilterOptionImplCopyWith<_$FilterOptionImpl> get copyWith =>
      __$$FilterOptionImplCopyWithImpl<_$FilterOptionImpl>(this, _$identity);
}

abstract class _FilterOption implements FilterOption {
  const factory _FilterOption(
      {final String fromDate,
      final String toDate,
      final dynamic type,
      final String description,
      final dynamic tag,
      final FilterCondition? filterCondition,
      final String amount}) = _$FilterOptionImpl;

  @override
  String get fromDate;
  @override
  String get toDate;
  @override
  dynamic get type;
  @override
  String get description;
  @override
  dynamic get tag;
  @override
  FilterCondition? get filterCondition;
  @override
  String get amount;
  @override
  @JsonKey(ignore: true)
  _$$FilterOptionImplCopyWith<_$FilterOptionImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
