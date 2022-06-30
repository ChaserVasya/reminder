class DateTimeUtils {
  static DateTime toNearestNotifiable(DateTime reminder) {
    final now = DateTime.now();

    if (reminder.isAfter(now)) return reminder;

    return now.add(const Duration(minutes: 1));
  }
}
