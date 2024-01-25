// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'income.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

Income _$IncomeFromJson(Map<String, dynamic> json) {
  return _Income.fromJson(json);
}

/// @nodoc
mixin _$Income {
  String get id => throw _privateConstructorUsedError;
  String get userId => throw _privateConstructorUsedError;
  String get date => throw _privateConstructorUsedError;
  IncomeType get type => throw _privateConstructorUsedError;
  String get description => throw _privateConstructorUsedError;
  double get amount => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $IncomeCopyWith<Income> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $IncomeCopyWith<$Res> {
  factory $IncomeCopyWith(Income value, $Res Function(Income) then) =
      _$IncomeCopyWithImpl<$Res, Income>;
  @useResult
  $Res call(
      {String id,
      String userId,
      String date,
      IncomeType type,
      String description,
      double amount});
}

/// @nodoc
class _$IncomeCopyWithImpl<$Res, $Val extends Income>
    implements $IncomeCopyWith<$Res> {
  _$IncomeCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? userId = null,
    Object? date = null,
    Object? type = null,
    Object? description = null,
    Object? amount = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      date: null == date
          ? _value.date
          : date // ignore: cast_nullable_to_non_nullable
              as String,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as IncomeType,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      amount: null == amount
          ? _value.amount
          : amount // ignore: cast_nullable_to_non_nullable
              as double,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$IncomeImplCopyWith<$Res> implements $IncomeCopyWith<$Res> {
  factory _$$IncomeImplCopyWith(
          _$IncomeImpl value, $Res Function(_$IncomeImpl) then) =
      __$$IncomeImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String userId,
      String date,
      IncomeType type,
      String description,
      double amount});
}

/// @nodoc
class __$$IncomeImplCopyWithImpl<$Res>
    extends _$IncomeCopyWithImpl<$Res, _$IncomeImpl>
    implements _$$IncomeImplCopyWith<$Res> {
  __$$IncomeImplCopyWithImpl(
      _$IncomeImpl _value, $Res Function(_$IncomeImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? userId = null,
    Object? date = null,
    Object? type = null,
    Object? description = null,
    Object? amount = null,
  }) {
    return _then(_$IncomeImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      date: null == date
          ? _value.date
          : date // ignore: cast_nullable_to_non_nullable
              as String,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as IncomeType,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      amount: null == amount
          ? _value.amount
          : amount // ignore: cast_nullable_to_non_nullable
              as double,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$IncomeImpl implements _Income {
  const _$IncomeImpl(
      {required this.id,
      required this.userId,
      required this.date,
      required this.type,
      required this.description,
      required this.amount});

  factory _$IncomeImpl.fromJson(Map<String, dynamic> json) =>
      _$$IncomeImplFromJson(json);

  @override
  final String id;
  @override
  final String userId;
  @override
  final String date;
  @override
  final IncomeType type;
  @override
  final String description;
  @override
  final double amount;

  @override
  String toString() {
    return 'Income(id: $id, userId: $userId, date: $date, type: $type, description: $description, amount: $amount)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$IncomeImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.date, date) || other.date == date) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.amount, amount) || other.amount == amount));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, id, userId, date, type, description, amount);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$IncomeImplCopyWith<_$IncomeImpl> get copyWith =>
      __$$IncomeImplCopyWithImpl<_$IncomeImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$IncomeImplToJson(
      this,
    );
  }
}

abstract class _Income implements Income {
  const factory _Income(
      {required final String id,
      required final String userId,
      required final String date,
      required final IncomeType type,
      required final String description,
      required final double amount}) = _$IncomeImpl;

  factory _Income.fromJson(Map<String, dynamic> json) = _$IncomeImpl.fromJson;

  @override
  String get id;
  @override
  String get userId;
  @override
  String get date;
  @override
  IncomeType get type;
  @override
  String get description;
  @override
  double get amount;
  @override
  @JsonKey(ignore: true)
  _$$IncomeImplCopyWith<_$IncomeImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
