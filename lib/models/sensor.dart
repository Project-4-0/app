import 'package:b_one_project_4_0/models/sensorType.dart';

class Sensor {
  int id;
  String name;
  int sensorTypeID;
  SensorType sensorType;

  Sensor({this.id, this.name, this.sensorTypeID, this.sensorType});

  factory Sensor.fromJson(Map<String, dynamic> json) {
    return Sensor(
        id: json['SensorID'],
        name: json['Name'],
        sensorTypeID: json['SensorTypeID'],
        sensorType: json['SensorType'] == null
            ? null
            : SensorType.fromJson(json['SensorType']));
  }

  factory Sensor.fromJsonWithout(Map<String, dynamic> json) {
    return Sensor(
      id: json['SensorID'],
      name: json['Name'],
      sensorTypeID: json['SensorTypeID'],
    );
  }

  Map<String, dynamic> toJson() => {
        'Name': name,
        'SensorTypeID': sensorTypeID,
      };
}
