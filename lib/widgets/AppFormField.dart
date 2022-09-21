import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:todo_app_day1/constants/app_colors.dart';

class AppTextField extends StatelessWidget {
  AppTextField({
    Key? key,
    required this.TextFieldController,
    this.hintText,
    required this.isObsecure,
  }) : super(key: key);

  final TextEditingController TextFieldController;

  String? hintText;
  bool isObsecure;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: TextField(
        style: TextStyle(fontSize: 16),
        textCapitalization: TextCapitalization.sentences,
        autocorrect: false,
        // keyboardType: TextInputType.emailAddress,
        textInputAction: TextInputAction.next,
        controller: TextFieldController,
        autofocus: false,
        obscureText: isObsecure,
        decoration: InputDecoration(
          suffixIcon: Icon(FontAwesomeIcons.eye),
          hintText: hintText,
          fillColor: whiteShade.withOpacity(0.5),
          filled: true,
          border: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
    );
  }
}

class AppSearchField extends StatelessWidget {
  AppSearchField({
    Key? key,
    required this.TextFieldController,
    this.hintText,
    required this.isObsecure,
  }) : super(key: key);

  final TextEditingController TextFieldController;

  String? hintText;
  bool isObsecure;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: TextField(
        style: TextStyle(fontSize: 16),
        textCapitalization: TextCapitalization.sentences,
        autocorrect: false,
        // keyboardType: TextInputType.emailAddress,
        textInputAction: TextInputAction.next,
        controller: TextFieldController,
        autofocus: false,
        obscureText: isObsecure,
        decoration: InputDecoration(
          prefixIcon: Icon(FontAwesomeIcons.search),
          hintText: hintText,
          fillColor: whiteShade.withOpacity(0.5),
          filled: true,
          border: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
    );
  }
}

class AddCategoryField extends StatelessWidget {
  AddCategoryField({
    Key? key,
    required this.TextFieldController,
    this.hintText,
    required this.isObsecure,
  }) : super(key: key);

  final TextEditingController TextFieldController;

  String? hintText;
  bool isObsecure;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: TextField(
        style: TextStyle(fontSize: 16),
        textCapitalization: TextCapitalization.sentences,
        autocorrect: false,
        // keyboardType: TextInputType.emailAddress,
        textInputAction: TextInputAction.next,
        controller: TextFieldController,
        autofocus: false,
        obscureText: isObsecure,
        decoration: InputDecoration(
          hintText: hintText,
          fillColor: whiteShade.withOpacity(0.5),
          filled: true,
          border: OutlineInputBorder(
            // borderSide: BorderSide.none,
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
    );
  }
}
