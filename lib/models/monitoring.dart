import 'package:b_one_project_4_0/models/box.dart';

class Monitoring {
  int id;
  int boxID;
  String sdCapacity;
  String amountSatellite;
  String batteryPercentage;
  String temperature;
  DateTime timeStamp;
  Box box;

  Monitoring(
      {this.id,
      this.boxID,
      this.sdCapacity,
      this.amountSatellite,
      this.batteryPercentage,
      this.temperature,
      this.timeStamp,
      this.box});

  factory Monitoring.fromJson(Map<String, dynamic> json) {
    return Monitoring(
        id: json['MonitoringID'],
        boxID: json['BoxID'],
        sdCapacity: json['SdCapacity'] == null ? "" :json['SdCapacity'],
        amountSatellite: json['AmountSatellite'] == "" ? null :json['AmountSatellite'],
        batteryPercentage: json['BatteryPercentage'] == "" ? null : json['BatteryPercentage'],
        temperature: json['Temperature'] == null ? "" : json['Temperature'],
        timeStamp: json['TimeStamp'] == null
            ? null
            : DateTime.parse(json['TimeStamp']),
        box: json['Box'] == null ? null : Box.fromJson(json['Box']));
  }

  // Without extra tables included
  factory Monitoring.fromJsonW(Map<String, dynamic> json) {
    return Monitoring(
      id: json['MonitoringID'],
        boxID: json['BoxID'],
        sdCapacity: json['SdCapacity'],
        amountSatellite: json['AmountSatellite'],
        batteryPercentage: json['BatteryPercentage'],
        temperature: json['Temperature'],
        timeStamp: json['TimeStamp'] == null
            ? null
            : DateTime.parse(json['TimeStamp']),
    );
  }

  // Map<String, dynamic> toJson() => {
  //       'BoxID': boxID,
  //       'SDCapacity': sdCapacity,
  //       'BatteryStatus': batteryStatus,
  //       'BatteryPercentage': batteryPercentage,
  //     };
}
