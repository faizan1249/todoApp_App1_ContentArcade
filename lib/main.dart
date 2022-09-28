import 'package:flutter/material.dart';
import 'package:todo_app_day1/app.dart';
import 'package:flutter/services.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_background/flutter_background.dart';
import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'package:todo_app_day1/viewModel/notifications.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Firebase.initializeApp();
  await AndroidAlarmManager.initialize();
  NotificationService().initNotification();

  const androidConfig = FlutterBackgroundAndroidConfig(
    notificationTitle: "Todo App",
    notificationText: "Todo App is Running in Background",
    notificationImportance: AndroidNotificationImportance.Default,
    notificationIcon:
        AndroidResource(name: 'Background Icon', defType: 'drawable'),
  );
  bool hasPermission = await FlutterBackground.hasPermissions;
  print(hasPermission);
  if (hasPermission) {
    await FlutterBackground.initialize(androidConfig: androidConfig);
    await FlutterBackground.enableBackgroundExecution();
  }

  // if (hasPermission == true) {}

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  runApp(MyApp());
}
