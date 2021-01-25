import 'package:b_one_project_4_0/models/box.dart';

class SensorBox {
  int boxID;
  int sensorID;
  Box box;

  SensorBox({this.boxID, this.sensorID, this.box});

  factory SensorBox.fromJson(Map<String, dynamic> json) {
    return SensorBox(
        boxID: json['BoxID'],
        sensorID: json['SensorID'],
        box: Box.fromJson(json['Box']));
  }

  Map<String, dynamic> toJson() => {
        'BoxID': boxID,
        'SensorID': sensorID,
      };
}
