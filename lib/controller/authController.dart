import 'dart:convert';
import 'package:b_one_project_4_0/models/auth.dart';
import 'package:b_one_project_4_0/models/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

/*
Save authentication token internal storage.
Save user object internal storage, for display the user object
*/
class AuthController {
  static final String _authToken = "auth_token";
  static final String _userObject = "user";

  static Future<void> setAuthToken(Auth auth) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(_authToken, auth.token);
  }

  static Future<Auth> getAuthToken() async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    String token;
    token = pref.getString(_authToken) ?? null;
    return new Auth(token: token);
  }

  static Future<void> deleteAuthToken() async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    pref.remove(_authToken);
  }

  static Future<void> setUser(User newUser) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(_userObject, jsonEncode(newUser));
  }

  static Future<User> getUser() async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    String userString;
    userString = pref.getString(_userObject) ?? null;

    return User.fromJson(jsonDecode(userString));
  }

  static Future<void> deleteUser() async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    pref.remove(_userObject);
  }
}
