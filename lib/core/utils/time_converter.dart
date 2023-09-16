import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TimeConverter {
  static String formatTime({required TimeOfDay time}) {
    DateTime now = DateTime.now();
    DateTime dateTime =
        DateTime(now.year, now.month, now.day, time.hour, time.minute);
    String formattedTime = DateFormat.jm().format(dateTime);
    return formattedTime;
  }

  static DateTime scheduleDaily(TimeOfDay time) {
    final DateTime now = DateTime.now();
    final scheduleDate =
        DateTime(now.year, now.month, now.day, time.hour, time.minute);

    return scheduleDate.isBefore(now)
        ? scheduleDate.add(const Duration(days: 1))
        : scheduleDate;
  }
}
