import 'package:intl/intl.dart';

/// Currency formatter utility for Indonesian Rupiah.
class CurrencyFormatter {
  /// Formats integer into IDR currency, e.g. "Rp 25.000"
  static String format(int amount, {String locale = 'id_ID'}) {
    final formatter = NumberFormat.currency(
      locale: locale,
      symbol: 'Rp ',
      decimalDigits: 0,
    );
    return formatter.format(amount);
  }

  /// Formats nullable price, showing "Gratis" if null or 0.
  static String orFree(int? amount, {String locale = 'id_ID'}) {
    if (amount == null || amount == 0) return 'Gratis';
    return format(amount, locale: locale);
  }
}
