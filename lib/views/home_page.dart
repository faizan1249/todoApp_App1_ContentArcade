import 'package:flutter/material.dart';
import 'package:todo_app_day1/constants/app_colors.dart';
import 'package:todo_app_day1/model/categoryModel.dart';
import 'package:todo_app_day1/viewModel/homePageViewmodel.dart';
import 'package:todo_app_day1/widgets/AppFormField.dart';
import 'package:todo_app_day1/widgets/button.dart';
import 'package:flutter_material_color_picker/flutter_material_color_picker.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  static String id = "home_page";

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  IconData icon = Icons.question_mark;

  @override
  Widget build(BuildContext context) {
    HomePageViewModel homePageViewModel =
        Provider.of<HomePageViewModel>(context);

    TextEditingController searchController = new TextEditingController();
    Size size = MediaQuery.of(context).size;

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            color: Colors.black,
            iconSize: 32,
            icon: Icon(Icons.menu),
            onPressed: () {},
          ),
          centerTitle: true,
          title: const Text(
            "Home",
            style: TextStyle(
                fontSize: 22, fontWeight: FontWeight.bold, color: Colors.black),
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
                  padding: EdgeInsets.symmetric(horizontal: 30),
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
                    itemCount: homePageViewModel.caategoryList.length,
                    physics: ScrollPhysics(),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2),
                    itemBuilder: (context, index) {
                      return CategoryMenuCard(
                        categoryName: homePageViewModel
                            .getCategoryList[index].categoryName
                            .toString(),
                        cardColor:
                            homePageViewModel.getCategoryList[index].cardColor,
                        cardIcon: homePageViewModel
                            .getCategoryList[index].relevantIcon,
                      );
                    }),
                AddCategory(
                  list: homePageViewModel.getCategoryList,
                ),
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
              padding: EdgeInsets.only(bottom: 20),
              child: Align(
                alignment: AlignmentDirectional.bottomCenter,
                child: Text(
                  categoryName,
                  style: TextStyle(
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

class AddCategory extends StatefulWidget {
  List<CategoryModel>? list;
  AddCategory({this.list});

  @override
  State<AddCategory> createState() => _AddCategoryState();
}

class _AddCategoryState extends State<AddCategory> {
  Icon? _icon;
  Color pickedColor = Color(0xFF);
  var newIcon;

  @override
  Widget build(BuildContext context) {
    TextEditingController Addcontroller = TextEditingController();
    HomePageViewModel homePageViewModel =
        Provider.of<HomePageViewModel>(context, listen: true);

    return Container(
      child: InkWell(
        onTap: () {
          print("Add New Category");
          var pickerColor = Color(0xFF);
          var changeColor = Color(0xFF);
          showModalBottomSheet(
              isScrollControlled: true,
              context: context,
              builder: (context) {
                return StatefulBuilder(builder: ((context, setState) {
                  return Padding(
                    padding: const EdgeInsets.all(20),
                    child: Container(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: <Widget>[
                          Text(
                            "Category Name",
                            textAlign: TextAlign.left,
                            style: TextStyle(color: BlackShade, fontSize: 24),
                          ),
                          AddCategoryField(
                              TextFieldController: Addcontroller,
                              isObsecure: false),
                          MaterialColorPicker(
                            onColorChange: (Color color) {
                              pickedColor = color;
                              debugPrint(pickedColor.toString());
                            },
                            selectedColor: Colors.red,
                          ),
                          ElevatedButton(
                              onPressed: () async {
                                var icon;
                                try {
                                  await homePageViewModel.pickIcon(context);
                                  setState(() {
                                    newIcon = homePageViewModel.getIconData;
                                  });
                                } on Exception catch (e) {
                                  print(e.toString());
                                }
                              },
                              child: Text("Select Icon")),
                          Container(
                            child: Icon(newIcon),
                          ),
                          buildButton("Add Category", () async {
                            String name = Addcontroller.value.text;
                            await homePageViewModel.addCategory(
                                name, pickedColor);

                            Navigator.pop(context);
                            // print("asdada");
                          }, purpleBlueLight, WhiteColor),
                        ],
                      ),
                    ),
                  );
                }));
              });
        },
        child: Container(
          child: Column(
            children: [
              Stack(alignment: Alignment.center, children: [
                Container(
                  width: 150,
                  height: 150,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      color: Colors.white,
                      border: Border.all(
                          color: Colors.black.withOpacity(0.4), width: 4)),
                  child: Icon(
                    Icons.add,
                    size: 32,
                    color: Colors.black.withOpacity(0.4),
                  ),
                ),
              ])
            ],
          ),
        ),
      ),
    );
  }
}