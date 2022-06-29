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
