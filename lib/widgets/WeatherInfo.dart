import 'package:flutter/material.dart';
import 'package:b_one_project_4_0/models/weather.dart';
import 'package:b_one_project_4_0/controller/weatherController.dart';
import 'package:intl/intl.dart';

class WeatherInfo extends StatefulWidget {
  final int boxID;
  WeatherInfo(this.boxID);

  @override
  State<StatefulWidget> createState() => _WeatherInfo(boxID);
}

class _WeatherInfo extends State<WeatherInfo> {
  int boxID;
  _WeatherInfo(this.boxID);

  Weather weather;

  String date;

  @override
  void initState() {
    super.initState();
    _getWeather(boxID);
  }

  // Get the weather for the location of a specific box
  void _getWeather(int boxID) {
    WeatherController.getWeatherInfo(this.boxID).then((weather) {
      var now = new DateTime.now();
      var formatter = new DateFormat('EEE - d MMM');
      String formattedDate = formatter.format(now);
      print(formattedDate); // 2016-01-25
      setState(() {
        this.weather = weather;
        this.date = formattedDate;
      });
      print(this.weather.cityName);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.fromLTRB(0.0, 20.0, 0.0, 20.0),
        child: weather != null
            ? Container(
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor,
                  borderRadius: BorderRadius.circular(5.0),
                ),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                          flex: 3,
                          child: Column(
                            children: [
                              Text(
                                this.weather.cityName,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 30,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Poppins',
                                ),
                              ),
                              if (this.date != null) Text(this.date),
                              Container(
                                height: 1,
                                width: 150,
                                color: Colors.white,
                              ),
                              Row(
                                children: [
                                  Column(
                                    children: [
                                      Text(
                                        this.weather.temp.toString() + "°C",
                                        style: TextStyle(fontSize: 30.0),
                                      ),
                                      Text(
                                          this.weather.tempMin.toString() +
                                              " / " +
                                              this.weather.tempMax.toString() +
                                              "°C",
                                          style: TextStyle(fontSize: 14.0)),
                                      Text("Voelt aan als: " +
                                          this.weather.feelsLike.toString() +
                                          "°C"),
                                      Row(
                                        children: [
                                          SizedBox(
                                            // height: 100.0,
                                            width: 24.0,
                                            child: Image.network(
                                                'http://openweathermap.org/img/wn/' +
                                                    this.weather.weatherIcon +
                                                    '@2x.png'),
                                          ),
                                          Text(this.weather.weatherDescription),
                                        ],
                                      )
                                    ],
                                  ),
                                ],
                              ),

                              Container(
                                height: 1,
                                width: 150,
                                color: Colors.white,
                              ),

                              Row(children: [
                                Column(children: [
                                  Text("Wind: " +
                                      this.weather.windSpeed.toString() +
                                      "km/h" +
                                      " - " +
                                      this.weather.windDeg.toString() +
                                      "°"),
                                  Text("Pressure: " +
                                      this.weather.pressure.toString() +
                                      "hPa"),
                                  Text("Humidity: " +
                                      this.weather.humidity.toString() +
                                      "%"),
                                ])
                              ]),

                              // Text(this.weather.tempMin.toString() + "°C"),
                              // Text("min"),
                              // Text(this.weather.tempMax.toString() + "°C"),
                              // Text("max"),
                              // Text(this.weather.weatherMain),

                              // //ICON
                              // Text(this.weather.weatherDescription),
                              // Text(this.weather.pressure.toString() +
                              //     "hPa"), // Pressure
                              // Text(this.weather.humidity.toString() +
                              //     "%"), // Humidity
                            ],
                          )),
                      Expanded(
                          flex: 1,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Center(
                                  child: SizedBox(
                                // height: 100.0,
                                width: 100.0,
                                child: Image.network(
                                    'http://openweathermap.org/img/wn/' +
                                        this.weather.weatherIcon +
                                        '@2x.png'),
                              )),
                              Text(this.weather.weatherMain),
                            ],
                          ))
                    ]))
            : CircularProgressIndicator(
                valueColor: new AlwaysStoppedAnimation<Color>(
                    Theme.of(context).primaryColor),
              ));
  }
}
