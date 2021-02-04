import 'package:b_one_project_4_0/models/location.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class LocationApi {
  static String url = env['API_URL'];

  // GET: The location of a specific box
  static Future<Location>getLocationOfBox(int id) async {
    final response = await http.get(url + '/locations/box/' + id.toString());
    if (response.statusCode == 200) {
      return Location.fromJson(json.decode(response.body));
    } else {
      throw Exception(response.body);
    }
  }
}
