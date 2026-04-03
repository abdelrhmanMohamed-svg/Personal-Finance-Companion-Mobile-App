import 'package:intl/intl.dart';

class CurrencyUtils {
  static final NumberFormat _compactFormat = NumberFormat.compact();

  static String formatCurrency(double amount, {String symbol = '\$'}) {
    final format = NumberFormat.currency(
      symbol: symbol,
      decimalDigits: 2,
    );
    return format.format(amount);
  }

  static String formatCompact(double amount) {
    return _compactFormat.format(amount);
  }

  static double? parseCurrency(String value) {
    try {
      final cleanValue = value.replaceAll(RegExp(r'[^\d.-]'), '');
      return double.tryParse(cleanValue);
    } catch (e) {
      return null;
    }
  }

  static String formatPercentage(double value, {int decimals = 1}) {
    return '${(value * 100).toStringAsFixed(decimals)}%';
  }

  static String formatWithSign(double amount, {String symbol = '\$'}) {
    final sign = amount >= 0 ? '+' : '';
    final format = NumberFormat.currency(
      symbol: symbol,
      decimalDigits: 2,
    );
    return '$sign${format.format(amount)}';
  }
}
