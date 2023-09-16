import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';

class NotificationService {
  final AwesomeNotifications awesomeNotifications = AwesomeNotifications();

  Future<bool> initNotifications() async {
    return await awesomeNotifications.initialize('resource://drawable/splash', [
      NotificationChannel(
          channelKey: 'Daily schdeuled channel Key',
          channelName: 'Daily schdeuled channel Name',
          channelDescription: 'Daily schdeuled channel Description',
          importance: NotificationImportance.High,
          channelShowBadge: true,
          playSound: true,
          soundSource: 'resource://raw/n_sound'),
    ]);
  }

  Future<bool> requestPermission() async {
    return await awesomeNotifications.requestPermissionToSendNotifications();
  }

  void scheduleDailyNotification({
    required int id,
    required String title,
    required String body,
    required TimeOfDay time,
  }) {
    final now = DateTime.now();
    DateTime scheduledDate =
        DateTime(now.year, now.month, now.day, time.hour, time.minute, 0, 0, 0);

    if (scheduledDate.isBefore(now)) {
      scheduledDate = scheduledDate.add(const Duration(days: 1));
    }

    AwesomeNotifications().createNotification(
      content: NotificationContent(
        id: id,
        channelKey: 'Daily schdeuled channel Key',
        title: title,
        body: body,
      ),
      schedule: NotificationCalendar(
        hour: scheduledDate.hour,
        minute: scheduledDate.minute,
        second: 0,
        millisecond: 0,
        allowWhileIdle: true,
        repeats: true,
      ),
    );
  }

  Future<void> cancelNotification(int id) async {
    return await AwesomeNotifications().cancel(id);
  }
}
