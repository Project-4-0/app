class Weather {
  String weatherMain;
  String weatherDescription;
  String weatherIcon;
  double temp;
  double feels_like;
  double temp_min;
  double temp_max;
  double pressure;
  double humidity;
  double visibility;
  double windSpeed;
  double windDeg;
  double clouds;

  Weather(
      {this.weatherMain,
      this.weatherDescription,
      this.weatherIcon,
      this.temp,
      this.feels_like,
      this.temp_min,
      this.temp_max,
      this.pressure,
      this.humidity,
      this.visibility,
      this.windSpeed,
      this.windDeg,
      this.clouds});

  factory Weather.fromJson(Map<String, dynamic> json) {
    return Weather(
      weatherMain: json['weather']['main'],
      weatherDescription: json['weather']['description'],
      weatherIcon: json['weather']['icon'],
      temp: json['main']['temp'],
      // feels_like: json['boxCountNoneActive'],
      // temp_min: json['boxCountActive'],
      // temp_max: json['boxCountNoneActive'],
      // pressure: json['boxCountActive'],
      // humidity: json['boxCountNoneActive'],
      // visibility: json['boxCountActive'],
      // windSpeed: json['boxCountNoneActive'],
      // windDeg: json['boxCountNoneActive'],
      // clouds: json['boxCountNoneActive'],
    );
  }
}
