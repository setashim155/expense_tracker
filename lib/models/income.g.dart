// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'income.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$IncomeImpl _$$IncomeImplFromJson(Map<String, dynamic> json) => _$IncomeImpl(
      id: json['id'] as String,
      userId: json['userId'] as String,
      date: json['date'] as String,
      type: $enumDecode(_$IncomeTypeEnumMap, json['type']),
      description: json['description'] as String,
      amount: (json['amount'] as num).toDouble(),
    );

Map<String, dynamic> _$$IncomeImplToJson(_$IncomeImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'userId': instance.userId,
      'date': instance.date,
      'type': _$IncomeTypeEnumMap[instance.type]!,
      'description': instance.description,
      'amount': instance.amount,
    };

const _$IncomeTypeEnumMap = {
  IncomeType.salary: 'salary',
  IncomeType.realEstate: 'realEstate',
  IncomeType.interest: 'interest',
  IncomeType.revenue: 'revenue',
  IncomeType.others: 'others',
};
