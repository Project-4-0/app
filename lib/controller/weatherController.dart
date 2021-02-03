/*
WeatherController
*/
import 'package:b_one_project_4_0/apis/weather_api.dart';
import 'package:b_one_project_4_0/controller/snackbarController.dart';
import 'package:b_one_project_4_0/models/weather.dart';

class WeatherController {
  static Future<Weather> getWeatherInfo(int boxID) async {
    return WeatherApi.getWeatherInfo(boxID).then((weatherinfo) {
      print("Main weather type: " + weatherinfo.weatherMain);
      return weatherinfo;
    }).catchError((error) {
      SnackBarController().show(text: error, title: "Server", type: "ERROR");
      return null;
    });
  }
}
