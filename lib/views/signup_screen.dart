import 'package:flutter/material.dart';
import 'package:todo_app_day1/constants/app_colors.dart';
import 'package:todo_app_day1/views/login_screen.dart';
import 'package:todo_app_day1/widgets/AppFormField.dart';
import 'package:todo_app_day1/widgets/button.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SignUpScreen extends StatelessWidget {
  static String id = 'sign_up';
  @override
  Widget build(BuildContext context) {
    TextEditingController nameController = TextEditingController();
    TextEditingController emailController = TextEditingController();
    TextEditingController passwordController = TextEditingController();
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(""),
          backgroundColor: WhiteColor,
          elevation: 0,
        ),
        body: SingleChildScrollView(
          child: Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(horizontal: 30),
            color: WhiteColor,
            //height: MediaQuery.of(context).size.height,

            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 50),
                  child: Text("Hello ! Signup to get Started",
                      // textAlign: TextAlign.left,
                      style: TextStyle(
                          fontSize: 46,
                          color: BlackShade,
                          fontWeight: FontWeight.bold)),
                ),
                Form(
                  child: Column(
                    children: [
                      SizedBox(
                        height: size.height * 0.06,
                      ),
                      AppTextField(
                        TextFieldController: nameController,
                        isObsecure: false,
                        hintText: "Enter Your Name",
                      ),
                      AppTextField(
                        TextFieldController: emailController,
                        isObsecure: false,
                        hintText: "Enter Your Email",
                      ),
                      AppTextField(
                        TextFieldController: passwordController,
                        isObsecure: true,
                        hintText: "Enter Your Password",
                      ),
                      SizedBox(
                        height: size.height * 0.06,
                      ),
                    ],
                  ),
                ),
                buildButton("GET STARTED", () {
                  print("SignUp");
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
                      onTap: () {
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
    );
  }
}
