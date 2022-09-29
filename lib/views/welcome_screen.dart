import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:todo_app_day1/constants/app_colors.dart';
import 'package:todo_app_day1/views/login_screen.dart';
import 'package:todo_app_day1/views/signup_screen.dart';
import 'package:todo_app_day1/widgets/button.dart';

class WelcomeScreen extends StatelessWidget {
  static String id = '/welcome_screen';
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
        backgroundColor: WhiteColor,
        appBar: AppBar(
          backgroundColor: WhiteColor,
          title: Text(""),
          elevation: 0,
        ),
        body: SingleChildScrollView(
          child: Container(
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
                        style: TextStyle(fontSize: 21, color: purpleBlueDark),
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
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 40),
                    child: Column(
                      children: [
                        Text(
                          "What are What we Do",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: purpleBlueDark,
                              fontSize: 26),
                        ),
                        SizedBox(
                          height: size.height * 0.03,
                        ),
                        Text(
                          "Thousands of People are Using Let's do,for make To Do List for better Productivity",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: purpleBlueLight.withOpacity(0.7),
                              fontSize: 16),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: size.height * 0.05,
                  ),
                  buildButton("SIGN UP", () {
                    print("Go to SignUp");
                    Navigator.pushNamed(context, SignUpScreen.id);
                  }, purpleBlueLight, WhiteColor),
                  SizedBox(
                    height: size.height * 0.02,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Already Have an Account? ",
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: purpleBlueLight.withOpacity(0.7),
                            fontSize: 16),
                      ),
                      GestureDetector(
                        onTap: (){
                          Navigator.pushNamed(context, SignInScreen.id);
                        },
                        child: Text(
                          "LOG IN",
                          style: TextStyle(color: Colors.blue),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
