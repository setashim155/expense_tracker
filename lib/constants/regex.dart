abstract final class Regex {
  static String name = '^[a-zA-Z]+(?:[-\\s][a-zA-Z]+)?\$';
  static String email = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\\.[a-zA-Z]{2,}\$';
  static String currency = '^\\d+(\\.\\d{1,2})?\$';
  static String integer = '^[1-9]\\d*\$';
}
