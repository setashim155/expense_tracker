import 'dart:math' as math;
import 'package:intl/intl.dart';
import '../constants/enums.dart';

abstract final class Helper {
  /// Formats the currency into NPR format
  static String formatCurrency(double currency) {
    final numberFormat = NumberFormat.currency(locale: "en_US", symbol: "NPR ");

    return numberFormat.format(currency);
  }

  /// Formats the date either in date time form or string
  static String formatDate(dynamic date) {
    final dateFormat = DateFormat.yMMMd('en_US');

    return dateFormat.format(date is DateTime ? date : DateTime.parse(date));
  }

  static DateTime parseDate(String date) {
    final dateFormat = DateFormat.yMMMd('en_US');

    return dateFormat.parse(date);
  }

  static bool isMonthSame(String date, int month) {
    return parseDate(date).month == month;
  }

  static bool isYearSame(String date, int year) {
    return parseDate(date).year == year;
  }

  /// For removing whitespaces from the String
  static String trim(String text) => text.trim().replaceAll(RegExp('\\s+'), ' ');

  /// For generating years from 2000 to 2100
  static List<String> generateYears() {
    final List<String> years = [];

    for (int i = 2000; i <= 2100; i++) {
      years.add(i.toString());
    }

    return years;
  }

  static double getInterval(Map<Month, double> values) {
    final data = values.entries.map((e) => e.value).toList();
    final min = data.reduce(math.min);
    final max = data.reduce(math.max);

    return (max - min) / 12;
  }
}
