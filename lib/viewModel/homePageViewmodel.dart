import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconpicker/flutter_iconpicker.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:todo_app_day1/constants/app_colors.dart';
import 'package:todo_app_day1/model/categoryModel.dart';
import 'package:realm/realm.dart';

class HomePageViewModel with ChangeNotifier {
  Color pickedColor = Color(0xFF);
  late IconData pickedIcon;

  late int iconCodePoint;
  late String iconFontFamily;
  late String iconFontPackage;
  late bool iconDirection;

  List<CategoryModel> caategoryList = [
    CategoryModel(
        categoryName: "Daily Tasks",
        cardColor: orangePinkColor.value,
        // relevantIcon: FontAwesomeIcons.heart,
        iconInformation: [
          IconInformation(
            iconCodePoint: FontAwesomeIcons.heart.codePoint,
            iconFontFamily: FontAwesomeIcons.heart.fontFamily,
            iconFontPackage: FontAwesomeIcons.heart.fontPackage,
            IconDirection: FontAwesomeIcons.heart.matchTextDirection,
          ),
        ]),
    CategoryModel(
        categoryName: "School Tasks",
        cardColor: SkyblueColor.value,
        // relevantIcon: FontAwesomeIcons.bagShopping,
        iconInformation: [
          IconInformation(
            iconCodePoint: FontAwesomeIcons.bagShopping.codePoint,
            iconFontFamily: FontAwesomeIcons.bagShopping.fontFamily,
            iconFontPackage: FontAwesomeIcons.bagShopping.fontPackage,
            IconDirection: FontAwesomeIcons.bagShopping.matchTextDirection,
          ),
        ]),
    CategoryModel(
        categoryName: "Shopping Lists",
        cardColor: pink.value,
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

  // Future<void> addCategory(String name, Color pickedColor) async {
  //   caategoryList.add(
  //     CategoryModel(
  //       categoryName: name,
  //       cardColor: pickedColor.value,
  //       relevantIcon: getIconData,
  //     ),
  //   );
  //   setCategoryList = caategoryList;
  // }

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
