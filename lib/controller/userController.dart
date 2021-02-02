/*
Usercontroller
*/
import 'package:b_one_project_4_0/apis/user_api.dart';
import 'package:b_one_project_4_0/apis/usertype_api.dart';
import 'package:b_one_project_4_0/controller/snackbarController.dart';
import 'package:b_one_project_4_0/models/user.dart';
import 'package:b_one_project_4_0/models/userType.dart';
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

// Create user admin
  static Future<User> newUser(User user) async {
    return UserApi.newUserAdmin(user).then((user) {
      return user;
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
        SnackBarController()
            .show(text: "UserID not found", title: "backend", type: "ERROR");
        debugPrint(e);
      }

      return true;
    }).catchError((error) {
      SnackBarController()
          .show(text: error.message, title: "Server", type: "ERROR");
      return false;
    });
  }

  static Future<User> loadUser() async {
    var us = (await AuthController.getUser());
    return UserApi.fetchUser(us.id).then((user) {
      return user;
    }).catchError((error) {
      SnackBarController()
          .show(text: error.message, title: "Server", type: "ERROR");
      return null;
    });
  }

  static Future<User> loadUserWithBoxes() async {
    var us = (await AuthController.getUser());
    return UserApi.fetchUserWithBox(us.id).then((user) {
      return user;
    }).catchError((error) {
      SnackBarController()
          .show(text: error.message, title: "Server", type: "ERROR");
      return null;
    });
  }

  static Future<bool> setUser(User user) async {
    print("User is here");
    return UserApi.updateUser(user).then((user) {
      return true;
    }).catchError((error) {
      SnackBarController()
          .show(text: error.message, title: "Server", type: "ERROR");
      return false;
    });
  }

  static Future<List<User>> loadUsers() async {
    return UserApi.fetchUsers().then((userList) {
      print("Number of users in controller: " + userList.length.toString());
      return userList;
    }).catchError((error) {
      SnackBarController()
          .show(text: error.message, title: "Server", type: "ERROR");
      return null;
    });
  }

  static Future<User> loadUserById(int id) async {
    return UserApi.fetchUser(id).then((user) {
      return user;
    }).catchError((error) {
      SnackBarController()
          .show(text: error.message, title: "Server", type: "ERROR");
      return null;
    });
  }

  static Future<User> loadUserByIdWithBoxes(int id) async {
    print("Load user with with boxes: " + id.toString());
    return UserApi.fetchUserWithBox(id).then((user) {
      return user;
    }).catchError((error) {
      SnackBarController()
          .show(text: error.message, title: "Server", type: "ERROR");
      return null;
    });
  }

  static Future<User> updateUsers(User user) async {
    return UserApi.updateUser(user).then((user) {
      // print("Number of users in controller: " + user.firstName);
      return user;
    }).catchError((error) {
      SnackBarController()
          .show(text: error.message, title: "Server", type: "ERROR");
      return null;
    });
  }

  // Get all user types
  static Future<List<UserType>> loadUserTypes() async {
    return UserTypeApi.fetchUserTypes().then((userTypeList) {
      return userTypeList;
    }).catchError((error) {
      SnackBarController()
          .show(text: error.message, title: "Server", type: "ERROR");
      return null;
    });
  }

  // GET userType by name
  static Future<UserType> loadUserTypeByName(String userTypeName) async {
    return UserTypeApi.fetchUserTypeByName(userTypeName).then((userType) {
      return userType;
    }).catchError((error) {
      SnackBarController()
          .show(text: error.message, title: "Server", type: "ERROR");
      return null;
    });
  }

  static Future<User> addBoxUser(int userID, int boxID) async {
    return UserApi.addBoxUser(userID, boxID).then((user) {
      return user;
    }).catchError((error) {
      SnackBarController()
          .show(text: error.message, title: "Server", type: "ERROR");
      return false;
    });
  }
}
