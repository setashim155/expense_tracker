import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'expense.freezed.dart';

part 'expense.g.dart';

// For expense category
enum ExpenseType {
  emi(text: 'EMI', iconPath: 'assets/images/emi.png', color: Colors.white),
  fundTransfer(text: 'Fund Transfer', iconPath: 'assets/images/fund_transfer.png', color: Colors.green),
  food(text: 'Food', iconPath: 'assets/images/food.png', color: Colors.red),
  fuel(text: 'Fuel', iconPath: 'assets/images/fuel.png', color: Colors.amber),
  groceries(text: 'Groceries', iconPath: 'assets/images/groceries.png', color: Colors.blue),
  shopping(text: 'Shopping', iconPath: 'assets/images/shopping.png', color: Colors.grey),
  rent(text: 'Rent', iconPath: 'assets/images/rent.png', color: Colors.purpleAccent),
  utilities(text: 'Utilities', iconPath: 'assets/images/utilities.png', color: Colors.cyanAccent),
  health(text: 'Health', iconPath: 'assets/images/health.png', color: Colors.lime),
  travel(text: 'Travel', iconPath: 'assets/images/travel.png', color: Colors.tealAccent),
  entertainment(text: 'Entertainment', iconPath: 'assets/images/entertainment.png', color: Colors.pink),
  tax(text: 'Tax', iconPath: 'assets/images/tax.png', color: Colors.purple),
  others(text: 'Others', iconPath: 'assets/images/others.png', color: Colors.blueGrey);

  final String text;
  final String iconPath;
  final Color color;

  const ExpenseType({
    required this.text,
    required this.iconPath,
    required this.color,
  });
}

// For expense tag
enum ExpenseTag {
  personal(text: 'Personal'),
  business(text: 'Business');

  final String text;

  const ExpenseTag({required this.text});
}

@freezed
class Expense with _$Expense {
  const factory Expense({
    required String id,
    required String userId,
    required String date,
    required ExpenseType type,
    required String description,
    required ExpenseTag tag,
    required double amount,
  }) = _Expense;

  factory Expense.fromJson(Map<String, dynamic> json) => _$ExpenseFromJson(json);
}
