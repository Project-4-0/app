import 'package:b_one_project_4_0/models/weather.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class WeatherApi {
  static String url = env['API_URL'];

  // GET: the weather info for a box his location
  static Future<Weather> getWeatherInfo(int boxID) async {
    final response = await http.get(url + '/weather/box/' + boxID.toString());
    if (response.statusCode == 200) {
      return Weather.fromJson(jsonDecode(response.body)['result']);
    } else {
      throw Exception(response.body);
    }
  }
}
