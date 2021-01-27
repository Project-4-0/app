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

  // GET: One user type
  static Future<UserType> fetchUserType(int id) async {
    final response = await http.get(url + '/userTypes/' + id.toString());
    if (response.statusCode == 200) {
      return UserType.fromJson(jsonDecode(response.body));
    } else {
      throw Exception(response.body);
    }
  }

}
