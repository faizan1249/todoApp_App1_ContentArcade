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
  List<CategoryModel> caategoryList = [
    CategoryModel(
        categoryName: "Daily Tasks",
        cardColor: orangePinkColor,
        relevantIcon: FontAwesomeIcons.heart),
    CategoryModel(
        categoryName: "School Tasks",
        cardColor: SkyblueColor,
        relevantIcon: FontAwesomeIcons.bagShopping),
    CategoryModel(
        categoryName: "Shopping Lists",
        cardColor: pink,
        relevantIcon: FontAwesomeIcons.cartShopping),
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

  Future<void> addCategory(String name, Color pickedColor) async {
    caategoryList.add(
      CategoryModel(
        categoryName: name,
        cardColor: pickedColor,
        relevantIcon: getIconData,
      ),
    );
    setCategoryList = caategoryList;
  }

  Future<IconData> pickIcon(BuildContext context) async {
    pickedIcon = await FlutterIconPicker.showIconPicker(context,
        iconPackModes: [IconPack.fontAwesomeIcons]) as IconData;
    setIconData = pickedIcon;

    debugPrint('Picked Icon: $getIconData');
    return getIconData;
  }
}
