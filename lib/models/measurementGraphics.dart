import 'package:b_one_project_4_0/models/box.dart';
import 'package:b_one_project_4_0/models/measurement.dart';

class MeasurementGraphics {
  List<Measurement> measurementsList;
  List<Box> boxes;

  MeasurementGraphics({
    this.measurementsList,
    this.boxes,
  });

  factory MeasurementGraphics.fromJson(Map<String, dynamic> json) {
    return MeasurementGraphics(
      measurementsList: json['Measurements'] == null
          ? null
          : (json['Measurements'] as List)
              .map((tagJson) => Measurement.fromJson(tagJson))
              .toList(),
      boxes: json['Boxes'] == null
          ? null
          : (json['Boxes'] as List)
              .map((tagJson) => Box.fromJson(tagJson))
              .toList(),
    );
  }

  // Map<String, dynamic> toJson() => {
  //       'BoxID': boxID,
  //       'SensorID': sensorID,
  //       'Value': value,
  //       'TimeStamp': timeStamp,
  //     };
}
