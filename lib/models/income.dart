import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'income.freezed.dart';

part 'income.g.dart';

enum IncomeType {
  salary(text: 'Salary', iconPath: 'assets/images/salary.png', color: Colors.green),
  realEstate(text: 'Real Estate', iconPath: 'assets/images/real_estate.png', color: Colors.amber),
  interest(text: 'Interest', iconPath: 'assets/images/interest.png', color: Colors.blue),
  revenue(text: 'Revenue', iconPath: 'assets/images/revenue.png', color: Colors.red),
  others(text: 'Others', iconPath: 'assets/images/others.png', color: Colors.white);

  final String text;
  final String iconPath;
  final Color color;

  const IncomeType({
    required this.text,
    required this.iconPath,
    required this.color,
  });
}

@freezed
class Income with _$Income {
  const factory Income({
    required String id,
    required String userId,
    required String date,
    required IncomeType type,
    required String description,
    required double amount,
  }) = _Income;

  factory Income.fromJson(Map<String, dynamic> json) => _$IncomeFromJson(json);
}
