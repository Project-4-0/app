class SensorBox {
  int boxID;
  int sensorID;

  SensorBox({
    this.boxID,
    this.sensorID,
  });

  factory SensorBox.fromJson(Map<String, dynamic> json) {
    return SensorBox(
      boxID: json['BoxID'],
      sensorID: json['SensorID'],
    );
  }

  Map<String, dynamic> toJson() => {
        'BoxID': boxID,
        'SensorID': sensorID,
      };
}
