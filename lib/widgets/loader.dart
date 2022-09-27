import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:todo_app_day1/constants/app_colors.dart';
class FullScreenLoader extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SpinKitWanderingCubes(
          size: 100,
          color: purpleBlueDark,
        ),
      ),
    );
  }
}
