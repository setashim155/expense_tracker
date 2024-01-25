// For type of transaction
import 'package:flutter/material.dart';

enum TransactionType {
  income(text: 'Income'),
  expense(text: 'Expense'),
  incomeAndExpense(text: 'Income and Expense');

  final String text;

  const TransactionType({required this.text});
}

// For chart type
enum ChartType {
  pieChart(text: 'Pie Chart'),
  lineChart(text: 'Line Chart'),
  barChart(text: 'Bar Chart');

  final String text;

  const ChartType({required this.text});
}

// For chart period
enum ChartPeriod {
  monthly(text: 'Monthly'),
  yearly(text: 'Yearly');

  final String text;

  const ChartPeriod({required this.text});
}

// For months
enum Month {
  jan(text: 'January', color: Colors.white),
  feb(text: 'February', color: Colors.red),
  mar(text: 'March', color: Colors.blue),
  apr(text: 'April', color: Colors.green),
  may(text: 'May', color: Colors.amber),
  jun(text: 'June', color: Colors.cyan),
  jul(text: 'July', color: Colors.teal),
  aug(text: 'August', color: Colors.purpleAccent),
  sept(text: 'September', color: Colors.blueGrey),
  oct(text: 'October', color: Colors.orange),
  nov(text: 'November', color: Colors.grey),
  dec(text: 'December', color: Colors.lime);

  final String text;
  final Color color;

  const Month({
    required this.text,
    required this.color,
  });
}
