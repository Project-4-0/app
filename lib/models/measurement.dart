class Measurement {
  int id;
  int boxID;
  int sensorID;
  String value;
  DateTime timeStamp;

  Measurement({
    this.id,
    this.boxID,
    this.sensorID,
    this.value,
    this.timeStamp,
  });

  factory Measurement.fromJson(Map<String, dynamic> json) {
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
