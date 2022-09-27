import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import 'package:flutter/material.dart';

class NotificationService {
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  Future<void> initNotification() async {
    final AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings(
            '@mipmap/ic_launcher'); // should mention the app icon
    // during initialization itself

    final InitializationSettings initializationSettings =
        InitializationSettings(android: initializationSettingsAndroid);

    await flutterLocalNotificationsPlugin.initialize(initializationSettings);
  }

  Future<void> showSingleNotification() async {
    // Duration offsetTime = DateTime.now().
    // tz.TZDateTime zonedTime =
    //     tz.TZDateTime.local(2022, 9, 27, 11, 59).subtract(offsetTime);
    AndroidNotificationDetails androidNotificationDetails =
        const AndroidNotificationDetails('main_channel', 'Main Channel',
            channelDescription: "faizan",
            importance: Importance.max,
            priority: Priority.max);
    NotificationDetails notificationDetails = NotificationDetails(
      android: androidNotificationDetails,
    );

    await flutterLocalNotificationsPlugin.show(
      0,
      "Alert !!!",
      "Please Add your Todo or Check it",
      notificationDetails,
    );
  }

  Future<void> scheduleNotifictions() async {
    print("Notification Initiazed");

    AndroidNotificationDetails androidNotificationDetails =
        const AndroidNotificationDetails(
      'main_channel',
      'Main Channel',
      channelDescription: "faizan",
      importance: Importance.max,
      priority: Priority.max,
    );
    NotificationDetails notificationDetails = NotificationDetails(
      android: androidNotificationDetails,
    );

    await flutterLocalNotificationsPlugin.periodicallyShow(
        1,
        "Scheduled Notiication",
        "ABC",
        RepeatInterval.everyMinute,
        notificationDetails);
    print("Notification Scheduled");
  }

  void stopNotifications() {
    flutterLocalNotificationsPlugin.cancel(1);
  }
}
