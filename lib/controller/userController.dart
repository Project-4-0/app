/*
Usercontroller
*/
import 'package:b_one_project_4_0/apis/user_api.dart';
import 'package:b_one_project_4_0/controller/snackbarController.dart';
import 'package:b_one_project_4_0/models/userRegistration.dart';
import 'package:flutter/cupertino.dart';

import 'authController.dart';

class UserController {
  static Future<bool> registration(UserRegistration user) async {
    return UserApi.createUser(user).then((auth) {
      return true;
    }).catchError((error) {
      SnackBarController()
          .show(text: error.message, title: "Server", type: "ERROR");
      return false;
    });
  }

  static Future<bool> login({String email, String password}) async {
    return UserApi.loginUser(email: email, password: password)
        .then((auth) async {
      // Set authToken
      AuthController.setAuthToken(auth);

      // get Users
      var user;
      try {
        user = await UserApi.fetchUser(auth.userID);
        AuthController.setUser(user);
      } catch (e) {
        debugPrint(e);
      }

      return true;
    }).catchError((error) {
      SnackBarController()
          .show(text: error.message, title: "Server", type: "ERROR");
      return false;
    });
  }
}
