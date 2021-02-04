import 'package:b_one_project_4_0/models/terrascope.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class TerrascopeAPI {
  static String url = env['API_URL'];

  // GET: One user type by ID
  static Future<Terrascope> fetchUrl(int id) async {
    final response = await http.get(url + '/terrascope/box/' + id.toString());
    if (response.statusCode == 200) {
      return Terrascope.fromJson(jsonDecode(response.body));
    } else {
      throw Exception(response.body);
    }
  }
}