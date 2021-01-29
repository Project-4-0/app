import 'package:b_one_project_4_0/models/box.dart';

class Monitoring {
  int id;
  int boxID;
  String sdCapacity;
  bool batteryStatus;
  double batteryPercentage;
  DateTime endDate;
  Box box;

  Monitoring(
      {this.id,
      this.boxID,
      this.sdCapacity,
      this.batteryStatus,
      this.batteryPercentage,
      this.endDate,
      this.box});

  factory Monitoring.fromJson(Map<String, dynamic> json) {
    return Monitoring(
        id: json['MonitoringID'],
        boxID: json['BoxID'],
        sdCapacity: json['SDCapacity'],
        batteryStatus: json['BatteryStatus'],
        batteryPercentage: json['BatteryPercentage'],
        box: json['Box'] == null ? null : Box.fromJson(json['Box']));
  }

  // Without extra tables included
  factory Monitoring.fromJsonW(Map<String, dynamic> json) {
    return Monitoring(
      id: json['MonitoringID'],
      boxID: json['BoxID'],
      sdCapacity: json['SDCapacity'],
      batteryStatus: json['BatteryStatus'],
      batteryPercentage: json['BatteryPercentage'],
    );
  }

  Map<String, dynamic> toJson() => {
        'BoxID': boxID,
        'SDCapacity': sdCapacity,
        'BatteryStatus': batteryStatus,
        'BatteryPercentage': batteryPercentage,
      };
}
