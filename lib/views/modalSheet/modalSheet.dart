import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../constants/app_colors.dart';
import '../../model/categoryModel.dart';
import 'package:provider/provider.dart';
import '../../viewModel/homePageViewmodel.dart';
import '../../widgets/AppFormField.dart';

import 'package:flutter_material_color_picker/flutter_material_color_picker.dart';

import '../../widgets/button.dart';
import 'dateTimePicker.dart';

class AddCategory extends StatefulWidget {
  List<CategoryModel>? list;
  AddCategory({this.list});

  @override
  State<AddCategory> createState() => _AddCategoryState();
}

class _AddCategoryState extends State<AddCategory> {
  Icon? _icon;
  Color pickedColor = const Color(0xFF);
  var newIcon;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    IconData heart = FontAwesomeIcons.heart;
    print(heart.codePoint);
  }

  @override
  Widget build(BuildContext context) {

    TextEditingController Addcontroller = TextEditingController();
    HomePageViewModel homePageViewModel =
    Provider.of<HomePageViewModel>(context, listen: true);

    return Container(
      child: InkWell(
        onTap: () {
          print("Add New Category");
          var pickerColor = const Color(0xFF);
          var changeColor = const Color(0xFF);
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
                          DateTimePicker(),


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
                              child: const Text("Select Icon")),
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