import 'package:b_one_project_4_0/models/userRegistration.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../models/userType.dart';

class UserTypeApi {
  static String url = env['API_URL'];

  // GET: All user types
  static Future<List<UserType>> fetchUserTypes() async {
    final response = await http.get(url + '/userTypes');
    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      return jsonResponse.map((userType) => new UserType.fromJson(userType)).toList();
    } else {
      throw Exception(response.body);
    }
  }

  // GET: One user type by ID
  static Future<UserType> fetchUserType(int id) async {
    final response = await http.get(url + '/userTypes/' + id.toString());
    if (response.statusCode == 200) {
      return UserType.fromJson(jsonDecode(response.body));
    } else {
      throw Exception(response.body);
    }
  }

    // POST: Get one user type by NAME
  static Future<UserType> fetchUserTypeByName(String userTypeName) async {
      final http.Response response = await http.post(
      url + '/userTypes/name',
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
      'UserTypeName': userTypeName,
    }),
    );
    if (response.statusCode == 200) {
      return UserType.fromJson(jsonDecode(response.body));
    } else {
      throw Exception(response.body);
    }
  }

}
