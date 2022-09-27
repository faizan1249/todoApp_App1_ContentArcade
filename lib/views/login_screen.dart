import 'package:flutter/material.dart';
import 'package:todo_app_day1/constants/app_colors.dart';
import 'package:todo_app_day1/viewModel/login_screen_viewModel.dart';
import 'package:todo_app_day1/views/home_page.dart';
import 'package:todo_app_day1/widgets/AppFormField.dart';
import 'package:todo_app_day1/widgets/button.dart';
import 'package:provider/provider.dart';

class SignInScreen extends StatelessWidget {
  static String id = '/signInScreen';
  TextEditingController EmailController = TextEditingController();
  TextEditingController PasswordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    LoginScreenViewModel loginviewModel =
        Provider.of<LoginScreenViewModel>(context, listen: false);

    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        backgroundColor: WhiteColor,
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.all(20.0),
          child: BottomAppBar(
            elevation: 0,
            color: WhiteColor,
            child: GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Text(
                "SIGN UP",
                textAlign: TextAlign.center,
                style: TextStyle(color: purpleBlueDark, fontSize: 14),
              ),
            ),
          ),
        ),
        appBar: AppBar(
          title: Text(""),
          backgroundColor: WhiteColor,
          elevation: 0,
        ),
        body: SingleChildScrollView(
          child: Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(horizontal: 30),

            //height: MediaQuery.of(context).size.height,

            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 50),
                  child: Text("Hello Again! Welcome Back",
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
                        TextFieldController: EmailController,
                        isObsecure: false,
                        hintText: "Enter Email Address",
                      ),
                      AppTextField(
                        TextFieldController: PasswordController,
                        isObsecure: true,
                        hintText: "Password",
                      ),
                      SizedBox(
                        height: size.height * 0.06,
                      ),
                    ],
                  ),
                ),
                buildButton("LOGIN", () async {
                  await loginviewModel.userSignIn(
                    EmailController.value.text.toString().trim(),
                    PasswordController.value.text.toString().trim(),
                  );

                  
                  if (loginviewModel.getloginStatus == true) {
                    Navigator.pushNamed(context, HomePage.id);
                    const snackbar = SnackBar(
                      content: Text("Login Successful"),
                    );
                    ScaffoldMessenger.of(context).showSnackBar(snackbar);
                  } else {
                    const snackbar = SnackBar(
                      content: Text("Login Faild"),
                    );
                    ScaffoldMessenger.of(context).showSnackBar(snackbar);
                  }
                  print("Sign In");
                }, purpleBlueLight, WhiteColor),
                SizedBox(
                  height: size.height * 0.02,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
