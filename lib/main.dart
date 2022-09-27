import 'package:flutter/material.dart';
import 'package:todo_app_day1/app.dart';
import 'package:flutter/services.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_background/flutter_background.dart';
import 'package:workmanager/workmanager.dart';

void callbackDispatcher() {
  Workmanager().executeTask((taskName, inputData) {
    print(
        "Native called background task: $taskName"); //simpleTask will be emitted here.
    return Future.value(true);
  });
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Firebase.initializeApp();
  Workmanager().initialize(callbackDispatcher, isInDebugMode: true);
  // Workmanager().registerOneOffTask('test_task', "Simple Task");
  Workmanager().registerPeriodicTask('test_task_repeat', "Another Simple Task",
      frequency: Duration(minutes: 15), initialDelay: Duration(seconds: 10));

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
