import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconpicker/flutter_iconpicker.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:todo_app_day1/constants/app_colors.dart';
import 'package:todo_app_day1/enum/app_status.dart';
import 'package:todo_app_day1/model/categoryModel.dart';
import 'package:realm/realm.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:todo_app_day1/viewModel/notifications.dart';
import 'package:intl/intl.dart';

class HomePageViewModel with ChangeNotifier {
  Color pickedColor = Color(0xFF);
  late IconData pickedIcon;
  var config;
  var realm;
  var allCategories;
  late DateTime _todoDateTime;

  DateTime get gettodoDateTime => _todoDateTime;

  set settodoDateTime(DateTime todoDateTime) {
    _todoDateTime = todoDateTime;
    notifyListeners();
  }

  AppStatus _appStatus = AppStatus.LOADING;
  set setAppStatus(AppStatus newAppStatus) {
    _appStatus = newAppStatus;
    notifyListeners();
  }

  AppStatus get getAppStatus => _appStatus;
  void deleteRealmFile() {
    config =
        Configuration.local([CategoryModel.schema, IconInformation.schema]);
    realm = Realm(config);
    print(realm.toString());

    allCategories = realm.all<CategoryModel>();
    print(allCategories);

    realm.write(() {
      realm.deleteMany(allCategories);
      notifyListeners();
    });
  }

  Future<void> AllCategoriesFunc({showLoading = true}) async {
    if (showLoading) {
      setAppStatus = AppStatus.LOADING;
    }
    config =
        Configuration.local([CategoryModel.schema, IconInformation.schema]);
    realm = Realm(config);
    allCategories = realm.all<CategoryModel>();
    setAllCategories = allCategories;
    setAppStatus = AppStatus.IDLE;
    print(allCategories.length);
    String FilePath = realm.config.path;
    print(FilePath);
  }

  List<CategoryModel> caategoryList = [
    CategoryModel(categoryName: "Daily Tasks", cardColor: orangePinkColor.value,
        // relevantIcon: FontAwesomeIcons.heart,
        iconInformation: [
          IconInformation(
            iconCodePoint: FontAwesomeIcons.heart.codePoint,
            iconFontFamily: FontAwesomeIcons.heart.fontFamily,
            iconFontPackage: FontAwesomeIcons.heart.fontPackage,
            IconDirection: FontAwesomeIcons.heart.matchTextDirection,
          ),
        ]),
    CategoryModel(categoryName: "School Tasks", cardColor: SkyblueColor.value,
        // relevantIcon: FontAwesomeIcons.bagShopping,
        iconInformation: [
          IconInformation(
            iconCodePoint: FontAwesomeIcons.bagShopping.codePoint,
            iconFontFamily: FontAwesomeIcons.bagShopping.fontFamily,
            iconFontPackage: FontAwesomeIcons.bagShopping.fontPackage,
            IconDirection: FontAwesomeIcons.bagShopping.matchTextDirection,
          ),
        ]),
    CategoryModel(categoryName: "Shopping Lists", cardColor: pink.value,
        // relevantIcon: FontAwesomeIcons.cartShopping,
        iconInformation: [
          IconInformation(
            iconCodePoint: FontAwesomeIcons.cartShopping.codePoint,
            iconFontFamily: FontAwesomeIcons.cartShopping.fontFamily,
            iconFontPackage: FontAwesomeIcons.cartShopping.fontPackage,
            IconDirection: FontAwesomeIcons.cartShopping.matchTextDirection,
          ),
        ]),
  ];

  set setAllCategories(dynamic newCategoryList) {
    allCategories = newCategoryList;
    notifyListeners();
  }

  dynamic get getAllCategories => allCategories;

  set setCategoryList(List<CategoryModel> Newlist) {
    Newlist = caategoryList;
    notifyListeners();
  }

  List<CategoryModel> get getCategoryList => caategoryList;
  //Setting Icon Data
  set setIconData(IconData NewIconData) {
    NewIconData = pickedIcon;
    notifyListeners();
  }

  IconData get getIconData => pickedIcon;

  Future<void> addCategory(
      String name, Color pickedColor, DateTime date, TimeOfDay time) async {
    FirebaseDatabase firebaseInstance = FirebaseDatabase.instance;
    firebaseInstance.setPersistenceEnabled(true);

    FirebaseFirestore firestore = FirebaseFirestore.instance;
    firestore.settings = const Settings(persistenceEnabled: true);

    Map<String, dynamic> body = {
      'CategoryName': name,
      'CardColor': pickedColor.value,
      'iconInformation': {
        'iconCodePoint': getIconData.codePoint,
        'iconFontFamily': getIconData.fontFamily,
        'iconFontPackage': getIconData.fontPackage,
        'IconDirection': getIconData.matchTextDirection,
      },
      'DateTime':
          DateTime(date.year, date.month, date.day, time.hour, time.minute),
    };

    firestore
        .collection('Categories')
        .doc(name)
        .set(body)
        .onError((error, stackTrace) => print(error));

    final docRef = firestore.collection("Categories").doc(name);
    await docRef.get().then(
      (DocumentSnapshot doc) {
        final data = doc.data() as Map<String, dynamic>;
        print(data);

        final Timestamp timestamp = data['DateTime'];
        // print(timestamp);
        final DateTime dateTime = timestamp.toDate();
        print(dateTime);
        print(DateFormat.yMMMd().format(dateTime));
        print(DateFormat.y().format(dateTime));
        print(DateFormat.M().format(dateTime));
        print(DateFormat.M().format(dateTime));

        settodoDateTime = dateTime;
      },
      onError: (e) => print("Error getting document: $e"),
    );

    var config =
        Configuration.local([CategoryModel.schema, IconInformation.schema]);
    var realm = Realm(config);
    // print(realm.config.fifoFilesFallbackPath);
    print("Assigning Category to Realm Variable");
    var category = CategoryModel(
        categoryName: name,
        cardColor: pickedColor.value,
        iconInformation: [
          IconInformation(
            iconCodePoint: getIconData.codePoint,
            iconFontFamily: getIconData.fontFamily,
            iconFontPackage: getIconData.fontPackage,
            IconDirection: getIconData.matchTextDirection,
          ),
        ]);
    print("Writing Category to DB");

    realm.write(() {
      realm.add(category);
      caategoryList.add(category);
      notifyListeners();
    });

    print("Writing Done");

    print("Scheduling Alarm .... ");
    fireAlarm();
  }

  static void sendNotification() {
    print("Send Notification Called at ${DateTime.now}");
    NotificationService notificationService = NotificationService();
    notificationService.showSingleNotification();
  }

  void fireAlarm() async {
    if (Platform.isAndroid) {
      AndroidAlarmManager alarmManager;
      print("Fire Alarm");
      print(DateFormat.H().format(gettodoDateTime));

      await AndroidAlarmManager.oneShotAt(
        exact: true,
        wakeup: true,
        DateTime(
            DateTime.now().year,
            DateTime.now().month,
            DateTime.now().day,
            int.parse(DateFormat.H().format(gettodoDateTime)),
            int.parse(DateFormat.m().format(gettodoDateTime))),
        0,
        sendNotification,
        rescheduleOnReboot: true,
      ).then((val) => print(val));
    }
  }

  Future<IconData> pickIcon(BuildContext context) async {
    pickedIcon = await FlutterIconPicker.showIconPicker(context,
        iconPackModes: [IconPack.fontAwesomeIcons]) as IconData;
    setIconData = pickedIcon;

    int iconCode = getIconData.codePoint;
    String iconFontFamily = getIconData.fontFamily.toString();
    String iconFontPackage = getIconData.fontPackage.toString();
    bool iconirection = getIconData.matchTextDirection;

    print("Icon Information");
    print("$iconCode + $iconFontFamily + $iconFontPackage + $iconirection");
    debugPrint('Picked Icon: $getIconData');
    return getIconData;
  }
}
