class DateTimeUtils {
  static DateTime toNearestNotifiable(DateTime reminder) {
    final now = DateTime.now();

    if (reminder.isAfter(now)) return reminder;

    return reminder.add(const Duration(minutes: 1));
  }
}
