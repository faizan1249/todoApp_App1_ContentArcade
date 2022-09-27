import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:todo_app_day1/viewModel/homePageViewmodel.dart';
import 'package:todo_app_day1/views/get_started.dart';
import 'package:todo_app_day1/views/home_page.dart';
import 'package:todo_app_day1/views/login_screen.dart';
import 'package:todo_app_day1/views/signup_screen.dart';
import 'package:todo_app_day1/views/welcome_screen.dart';
import 'views/get_started.dart';
import 'package:provider/provider.dart';
import 'viewModel/login_screen_viewModel.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<HomePageViewModel>(
          create: (_) => HomePageViewModel(),
        ),
        ChangeNotifierProvider<LoginScreenViewModel>(
          create: (_) => LoginScreenViewModel(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Todo App',
        initialRoute: GetStarted.id,
        routes: {
          GetStarted.id: ((context) => GetStarted()),
          WelcomeScreen.id: ((context) => WelcomeScreen()),
          SignUpScreen.id: ((context) => SignUpScreen()),
          SignInScreen.id: ((context) => SignInScreen()),
          HomePage.id: ((context) => HomePage()),
        },
        theme: ThemeData(
          brightness: Brightness.light,
          fontFamily: 'rubic',
        ),
        home: GetStarted(),
      ),
    );

    // return
  }
}
