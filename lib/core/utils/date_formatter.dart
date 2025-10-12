import 'package:intl/intl.dart';

/// Centralized date formatting utilities.
class DateFormatter {
  /// Formats a date into readable string like "Mon, 8 Oct 2025"
  static String short(DateTime date, {String locale = 'id_ID'}) {
    return DateFormat('EEE, d MMM yyyy', locale).format(date);
  }

  /// Formats a date into full version like "Monday, 8 October 2025"
  static String full(DateTime date, {String locale = 'id_ID'}) {
    return DateFormat('EEEE, d MMMM yyyy', locale).format(date);
  }

  /// Formats time like "14:30"
  static String time(DateTime date, {String locale = 'id_ID'}) {
    return DateFormat.Hm(locale).format(date);
  }
}
