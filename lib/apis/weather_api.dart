import 'package:b_one_project_4_0/models/weather.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class WeatherApi {
  static String url = env['API_URL'];

  // GET: All boxes
  static Future<Weather> getWeatherInfo() async {
    final response = await http.get(url + '/weather');
    if (response.statusCode == 200) {
      return Weather.fromJson(jsonDecode(response.body));
    } else {
      throw Exception(response.body);
    }
  }
}
