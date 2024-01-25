// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'expense.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ExpenseImpl _$$ExpenseImplFromJson(Map<String, dynamic> json) =>
    _$ExpenseImpl(
      id: json['id'] as String,
      userId: json['userId'] as String,
      date: json['date'] as String,
      type: $enumDecode(_$ExpenseTypeEnumMap, json['type']),
      description: json['description'] as String,
      tag: $enumDecode(_$ExpenseTagEnumMap, json['tag']),
      amount: (json['amount'] as num).toDouble(),
    );

Map<String, dynamic> _$$ExpenseImplToJson(_$ExpenseImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'userId': instance.userId,
      'date': instance.date,
      'type': _$ExpenseTypeEnumMap[instance.type]!,
      'description': instance.description,
      'tag': _$ExpenseTagEnumMap[instance.tag]!,
      'amount': instance.amount,
    };

const _$ExpenseTypeEnumMap = {
  ExpenseType.emi: 'emi',
  ExpenseType.fundTransfer: 'fundTransfer',
  ExpenseType.food: 'food',
  ExpenseType.fuel: 'fuel',
  ExpenseType.groceries: 'groceries',
  ExpenseType.shopping: 'shopping',
  ExpenseType.rent: 'rent',
  ExpenseType.utilities: 'utilities',
  ExpenseType.health: 'health',
  ExpenseType.travel: 'travel',
  ExpenseType.entertainment: 'entertainment',
  ExpenseType.tax: 'tax',
  ExpenseType.others: 'others',
};

const _$ExpenseTagEnumMap = {
  ExpenseTag.personal: 'personal',
  ExpenseTag.business: 'business',
};
