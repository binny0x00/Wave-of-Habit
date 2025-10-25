import 'package:intl/intl.dart';

/// Returns the current date in "yyyy-MM-dd" format.
///
/// This function uses the device's local time. For a strict timezone-based
/// implementation (like Asia/Seoul), a timezone-aware package would be necessary.
/// For the scope of this MVP, local time is sufficient.
String getTodayDate() {
  final now = DateTime.now();
  final formatter = DateFormat('yyyy-MM-dd');
  return formatter.format(now);
}
