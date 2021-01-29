import 'package:b_one_project_4_0/models/sensorBox.dart';

class Measurement {
  int id;
  int boxID;
  int sensorID;
  String value;
  DateTime timeStamp;
  SensorBox sensorBox;

  Measurement(
      {this.id,
      this.boxID,
      this.sensorID,
      this.value,
      this.timeStamp,
      this.sensorBox});

  factory Measurement.fromJson(Map<String, dynamic> json) {
    return Measurement(
        id: json['MeasurementID'],
        boxID: json['BoxID'],
        sensorID: json['SensorID'],
        value: json['Value'],
        timeStamp: json['TimeStamp'],
        sensorBox: SensorBox.fromJson(json['SensorBox']));
  }

  // Without extra tables included
  factory Measurement.fromJsonw(Map<String, dynamic> json) {
    return Measurement(
      id: json['MeasurementID'],
      boxID: json['BoxID'],
      sensorID: json['SensorID'],
      value: json['Value'],
      timeStamp: DateTime.parse(json['TimeStamp']),
    );
  }

  Map<String, dynamic> toJson() => {
        'BoxID': boxID,
        'SensorID': sensorID,
        'Value': value,
        'TimeStamp': timeStamp,
      };
}
