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
      // print(formattedDate); // 2016-01-25
      setState(() {
        this.weather = weather;
        this.date = formattedDate;
      });
      // print(this.weather.cityName);
    });
  }

  @override
  Widget build(BuildContext context) {
    // _getWeather(boxID);
    return Padding(
        padding: EdgeInsets.fromLTRB(0.0, 20.0, 0.0, 20.0),
        child: weather != null
            ? Container(
                padding: EdgeInsets.all(10.0),
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor,
                  borderRadius: BorderRadius.circular(5.0),
                ),
                child: Row(
                    // mainAxisAlignment: MainAxisAlignment.center,
                    // crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        flex: 3,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              this.weather.cityName,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 30,
                                fontWeight: FontWeight.w300,
                                fontFamily: 'Poppins',
                              ),
                              textAlign: TextAlign.left,
                            ),
                            if (this.date != null) Text(this.date),

                            Container(
                              height: 1,
                              width: 150,
                              color: Colors.white,
                              margin: EdgeInsets.fromLTRB(0.0, 2.0, 0.0, 5.0),
                            ),

                            // RichText(
                            //   text: TextSpan(
                            //     style: DefaultTextStyle.of(context).style,
                            //     children: <TextSpan>[
                            //       TextSpan(
                            //           text: this.weather.temp.toString(),
                            //           style: TextStyle(
                            //               fontWeight: FontWeight.bold, fontSize: 30.0,)),
                            //       TextSpan(text: " °C", style: TextStyle(color: Colors.white, fontSize: 30.0,)),
                            //     ],
                            //   ),
                            // ),

                            Text(
                              this.weather.temp.toString() + "°C",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 30.0,
                              ),
                              textAlign: TextAlign.left,
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
                                      'https://openweathermap.org/img/wn/' +
                                          this.weather.weatherIcon +
                                          '@2x.png'),
                                ),
                                Text(this.weather.weatherDescription),
                              ],
                            ),

                            Container(
                              height: 1,
                              width: 150,
                              color: Colors.white,
                              margin: EdgeInsets.fromLTRB(0.0, 2.0, 0.0, 5.0),
                            ),

                            Row(
                              children: [
                                Icon(
                                  Icons.waves, // Icon from parent
                                  color: Colors.white,
                                  size: 25,
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                // "Wind: " +
                                Text(this.weather.windSpeed.toString() +
                                    "m/s" +
                                    " - " +
                                    this.weather.windDeg.toString() +
                                    "°"),
                              ],
                            ),
                            Row(
                              children: [
                                Icon(
                                  Icons.speed, // Icon from parent
                                  color: Colors.white,
                                  size: 25,
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                // "Luchtdruk: " +
                                Text(this.weather.pressure.toString() + "hPa"),
                              ],
                            ),
                            Row(
                              children: [
                                Icon(
                                  Icons.opacity, // Icon from parent
                                  color: Colors.white,
                                  size: 25,
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                // "Vochtigheid: " +
                                Text(
                                  this.weather.humidity.toString() + "%",
                                ),
                              ],
                            ),

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
                        ),
                      ),
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
                                    'https://openweathermap.org/img/wn/' +
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
