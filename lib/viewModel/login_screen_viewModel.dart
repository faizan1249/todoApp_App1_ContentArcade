import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:todo_app_day1/enum/app_status.dart';

class LoginScreenViewModel with ChangeNotifier {
  AppStatus _appStatus = AppStatus.LOADING;
  final user = FirebaseAuth.instance;
  late bool _loginStatus;

  bool get getloginStatus => _loginStatus;

  set setloginStatus(bool loginStatus) {
    _loginStatus = loginStatus;
  }

  set setAppStatus(AppStatus newAppStatus) {
    _appStatus = newAppStatus;
    notifyListeners();
  }

  AppStatus get getAppStatus => _appStatus;

  Future<void> userSignIn(String email, String password,
      {showLoading = true}) async {
    if (showLoading) {
      setAppStatus = AppStatus.LOADING;
    }
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(
              email: "${email}", password: "${password}");
      setAppStatus = AppStatus.IDLE;
      setloginStatus = true;
    } on FirebaseAuthException catch (e) {
      setloginStatus = false;

      if (e.code == 'user-not-found') {
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
      }
    }
  }
}
