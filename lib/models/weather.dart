class Weather {
  String weatherMain;
  String weatherDescription;
  String weatherIcon;
  num temp;
  num feelsLike;
  num tempMin;
  num tempMax;
  num pressure;
  num humidity;
  num visibility;
  num windSpeed;
  num windDeg;
  num clouds;
  String cityName;

  Weather({
    this.weatherMain,
    this.weatherDescription,
    this.weatherIcon,
    this.temp,
    this.feelsLike,
    this.tempMin,
    this.tempMax,
    this.pressure,
    this.humidity,
    this.visibility,
    this.windSpeed,
    this.windDeg,
    this.clouds,
    this.cityName,
  });

  factory Weather.fromJson(Map<String, dynamic> json) {
    return Weather(
      weatherMain: json['weather'][0]['main'],
      weatherDescription: json['weather'][0]['description'],
      weatherIcon: json['weather'][0]['icon'],
      temp: json['main']['temp'],
      feelsLike: json['main']['feels_like'],
      tempMin: json['main']['temp_min'],
      tempMax: json['main']['temp_max'],
      pressure: json['main']['pressure'],
      humidity: json['main']['humidity'],
      visibility: json['visibility'],
      windSpeed: json['wind']['speed'],
      windDeg: json['wind']['deg'],
      clouds: json['clouds']['all'],
      cityName: json['name'],
    );
  }
}
