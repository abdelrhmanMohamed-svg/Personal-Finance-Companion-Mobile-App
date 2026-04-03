class AppConstants {
  static const String appName = 'Personal Finance Companion';
  static const String appVersion = '1.0.0';

  static const int pageSize = 20;
  static const int maxRetries = 3;
  static const Duration timeoutDuration = Duration(seconds: 30);

  static const String dateFormat = 'yyyy-MM-dd';
  static const String timeFormat = 'HH:mm:ss';
  static const String displayDateFormat = 'MMM dd, yyyy';

  static const double minAmount = 0.01;
  static const double maxAmount = 999999999.99;

  static const List<String> transactionCategories = [
    'Food & Dining',
    'Transportation',
    'Shopping',
    'Entertainment',
    'Bills & Utilities',
    'Healthcare',
    'Income',
    'Other',
  ];

  static const List<String> currencySymbols = [
    '\$',
    '€',
    '£',
    '¥',
    '₹',
  ];

  static const String defaultCurrency = '\$';
}
