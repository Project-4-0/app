// import 'package:gshop/models/UserRegistration.dart';
// import 'package:gshop/models/auth.dart';
import 'package:b_one_project_4_0/models/userRegistration.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../models/user.dart';
import '../models/auth.dart';

class UserApi {
  static String url = env['API_URL'];

  static Future<List<User>> fetchUsers() async {
    final response = await http.get(url + '/users');

    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      return jsonResponse.map((user) => new User.fromJson(user)).toList();
    } else {
      throw Exception(response.body);
    }
  }

  static Future<User> fetchUser(int id) async {
    final response = await http.get(url + '/users/' + id.toString());
    if (response.statusCode == 200) {
      return User.fromJson(jsonDecode(response.body));
    } else {
      throw Exception(response.body);
    }
  }

  // static Future<User> fetchUserByEmail(String email) async {
  //   final response = await http.get(url + '/users?email=' + email);
  //   if (response.statusCode == 200) {
  //     return User.fromJson(jsonDecode(response.body)[0]);
  //   } else {
  //     throw Exception(response.body);
  //   }
  // }

  static Future<Auth> createUser(UserRegistration user) async {
    final http.Response response = await http.post(
      url + '/signup',
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(user),
    );
    if (response.statusCode == 201) {
      return Auth.fromJson(jsonDecode(response.body));
    } else {
      throw Exception(response.body);
    }
  }

  static Future<User> updateUser(User user) async {
    final http.Response response = await http.put(
      url + '/users',
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(user),
    );
    if (response.statusCode == 200) {
      return User.fromJson(jsonDecode(response.body));
    } else {
      throw Exception(response.body);
    }
  }

  static Future deleteUser(int id) async {
    final http.Response response =
        await http.delete(url + '/users/' + id.toString());
    if (response.statusCode == 200) {
      return;
    } else {
      throw Exception(response.body);
    }
  }

  //Login user get authentication token back
  static Future<Auth> loginUser({String email, String password}) async {
    final http.Response response = await http.post(
      url + '/login',
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode({"Email": email, "Password": password}),
    );
    if (response.statusCode == 200) {
      return Auth.fromJson(jsonDecode(response.body));
    } else {
      throw Exception(response.body);
    }
  }
}
