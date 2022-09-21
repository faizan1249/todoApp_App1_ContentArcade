import 'package:flutter/material.dart';
import 'package:todo_app_day1/constants/app_colors.dart';

Widget buildButton(
    String btnText, Function() onPressed, Color fillColor, Color textColor) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: [
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: SizedBox(
          height: 50,
          child: TextButton(
            child: Text(
              btnText,
              style: TextStyle(color: textColor, fontSize: 18),
            ),
            style: ButtonStyle(
                visualDensity: VisualDensity.adaptivePlatformDensity,
                backgroundColor:
                    MaterialStateProperty.resolveWith((states) => fillColor),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                        side: BorderSide(color: WhiteColor)))),
            onPressed: onPressed,
          ),
        ),
      ),
    ],
  );
}
