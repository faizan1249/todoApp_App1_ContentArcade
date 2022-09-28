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

class HomePageViewModel with ChangeNotifier {
  Color pickedColor = Color(0xFF);
  late IconData pickedIcon;
  var config;
  var realm;
  var allCategories;

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

  Future<void> addCategory(String name, Color pickedColor) async {
    FirebaseDatabase firebaseInstance = FirebaseDatabase.instance;
    firebaseInstance.setPersistenceEnabled(true);
    DatabaseReference reference = firebaseInstance.ref('categories').push();
    reference.set({
      'CategoryName': name,
      'CardColor': pickedColor.value,
      'iconInformation': {
        'iconCodePoint': getIconData.codePoint,
        'iconFontFamily': getIconData.fontFamily,
        'iconFontPackage': getIconData.fontPackage,
        'IconDirection': getIconData.matchTextDirection,
      }
    });


    firebaseInstance.ref('categories');

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
