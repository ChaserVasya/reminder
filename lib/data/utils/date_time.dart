import 'package:flutter/material.dart';

extension DateTimeFactory on DateTime {
  static DateTime from(DateTime date, TimeOfDay time) {
    return DateTime(
      date.year,
      date.month,
      date.day,
      time.hour,
      time.minute,
    );
  }
}

class DateTimeUtils {
  static DateTime toNearestNotifiable(DateTime reminder) {
    final now = DateTime.now();

    if (reminder.isAfter(now)) return reminder;

    return now.add(const Duration(minutes: 1));
  }
}
