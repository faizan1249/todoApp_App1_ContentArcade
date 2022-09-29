import 'dart:io';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:todo_app_day1/constants/app_colors.dart';
import 'package:todo_app_day1/enum/app_status.dart';
import 'package:todo_app_day1/model/categoryModel.dart';
import 'package:todo_app_day1/viewModel/dateTimePickerViewModel.dart';
import 'package:todo_app_day1/viewModel/homePageViewmodel.dart';
import 'package:todo_app_day1/viewModel/notifications.dart';
import 'package:todo_app_day1/widgets/AppFormField.dart';
import 'package:todo_app_day1/widgets/button.dart';
import 'package:provider/provider.dart';
import 'package:realm/realm.dart';
import 'package:todo_app_day1/widgets/loader.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';

import 'modalSheet/modalSheet.dart';

class HomePage extends StatefulWidget {
  static String id = "home_page";

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  IconData icon = Icons.question_mark;
  var config;
  var realm;
  var allCategories;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      await Provider.of<HomePageViewModel>(context, listen: false)
          .AllCategoriesFunc();
      print("Length of List");
      print(Provider.of<HomePageViewModel>(context, listen: false)
          .getAllCategories
          .length);
    });

    // TODO: implement initState
    // realm = Realm(config);
    // realm.close();

    try {
      // Realm.deleteRealm(realm.config.path);
      print("File Deleted");
    } on Exception catch (e) {
      print(e.toString());
    }
    // realm.close();

    super.initState();
  }

  Widget build(BuildContext context) {
    HomePageViewModel homePageViewModel =
        Provider.of<HomePageViewModel>(context);

    DateTimePickerViewModel dateTimePickerViewModel =
        Provider.of<DateTimePickerViewModel>(context);

    TextEditingController searchController = new TextEditingController();
    Size size = MediaQuery.of(context).size;

    return homePageViewModel.getAppStatus == AppStatus.LOADING
        ? FullScreenLoader()
        : SafeArea(
            child: Scaffold(
              appBar: AppBar(
                actions: [
                  TextButton(
                      onPressed: () async {
                        await FirebaseAuth.instance.signOut();
                        const snackbar = SnackBar(
                          content: Text("User Logged Out"),
                        );

                        Navigator.pop(context);
                        ScaffoldMessenger.of(context).showSnackBar(snackbar);
                      },
                      child: Text("Sign Out"))
                ],
                leading: IconButton(
                  color: Colors.black,
                  iconSize: 32,
                  icon: const Icon(Icons.menu),
                  onPressed: () {},
                ),
                centerTitle: true,
                title: const Text(
                  "Home",
                  style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.black),
                ),
                backgroundColor: Colors.transparent,
                elevation: 0,
              ),
              body: Container(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.symmetric(horizontal: 30),
                        child: Column(
                          children: [
                            Container(
                              child: AppSearchField(
                                TextFieldController: searchController,
                                isObsecure: false,
                                hintText: "Search Tasks",
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.07,
                      ),
                      GridView.builder(
                          shrinkWrap: true,
                          itemCount: homePageViewModel.getAllCategories.length,
                          physics: const ScrollPhysics(),
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2),
                          itemBuilder: (context, index) {
                            return CategoryMenuCard(
                              categoryName: homePageViewModel
                                  .getAllCategories[index].categoryName
                                  .toString(),
                              cardColor: Color(homePageViewModel
                                  .getAllCategories[index].cardColor as int),
                              cardIcon: IconData(
                                homePageViewModel.getAllCategories[index]
                                    .iconInformation[0].iconCodePoint as int,
                                fontFamily: homePageViewModel
                                    .getAllCategories[index]
                                    .iconInformation[0]
                                    .iconFontFamily,
                                fontPackage: homePageViewModel
                                    .getAllCategories[index]
                                    .iconInformation[0]
                                    .iconFontPackage,
                                matchTextDirection: homePageViewModel
                                    .getAllCategories[index]
                                    .iconInformation[0]
                                    .IconDirection as bool,
                              ),
                            );
                          }),
                      AddCategory(
                        list: homePageViewModel.getCategoryList,
                      ),
                      ElevatedButton(
                          onPressed: () {
                            homePageViewModel.deleteRealmFile();
                          },
                          child: Text("Delete")),
                      ElevatedButton(
                          onPressed: () async {
                            homePageViewModel.fireAlarm();
                          },
                          child: Text("Schedule Notification")),
                    ],
                  ),
                  // child:
                ),
              ),
            ),
          );
  }
}

class CategoryMenuCard extends StatelessWidget {
  CategoryMenuCard(
      {required this.cardColor,
      required this.cardIcon,
      required this.categoryName});
  Color? cardColor;
  IconData? cardIcon;
  String categoryName;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 150,
          height: 150,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            color: cardColor,
          ),
          child: Stack(alignment: Alignment.center, children: [
            Container(
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(500)),
              width: 50,
              height: 50,
            ),
            Container(
              child: Icon(cardIcon),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 20),
              child: Align(
                alignment: AlignmentDirectional.bottomCenter,
                child: Text(
                  categoryName,
                  style: const TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ]),
        ),
      ],
    );
  }
}
