import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:todo_app_day1/views/welcome_screen.dart';
import 'package:todo_app_day1/widgets/button.dart';
import '../constants/app_colors.dart';

class GetStarted extends StatelessWidget {
  static String id = '/getStarted_screen';

  @override
  Widget build(BuildContext context) {
    // SystemChrome.setPreferredOrientations([
    //   DeviceOrientation.portraitUp,
    //   DeviceOrientation.portraitDown,
    //   // DeviceOrientation.landscapeLeft,
    //   // DeviceOrientation.landscapeRight,
    // ]);
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        body: Container(
          //height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(
              gradient: LinearGradient(
            colors: [purpleBlueDark, purpleBlueLight],
          )),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 50),
                  child: Column(children: [
                    Text(
                      "Let's Do",
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 21, color: whiteShade),
                    ),
                    SizedBox(
                      height: size.height * 0.05,
                    ),
                    Text(
                      "Hi Welcome To",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: whiteShade,
                          fontSize: 26),
                    ),
                    SizedBox(
                      height: size.height * 0.01,
                    ),
                    Text(
                      "Let's Do",
                      textAlign: TextAlign.center,
                      style: TextStyle(color: whiteShade, fontSize: 24),
                    ),
                    SizedBox(
                      height: size.height * 0.03,
                    ),
                    Text(
                      "Explore the App, Let's make to do list with Let's Do",
                      textAlign: TextAlign.center,
                      style: TextStyle(color: whiteShade, fontSize: 16),
                    ),
                  ]),
                ),
                Container(
                  child: Image.asset(
                    "assets/welcome.png",
                    width: 400,
                    height: 400,
                    fit: BoxFit.cover,
                  ),
                ),
                buildButton("GET STARTED", () {
                  Navigator.pushNamed(context, WelcomeScreen.id);
                }, WhiteColor, purpleBlueDark),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
