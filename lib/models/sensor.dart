class Sensor {
  int id;
  String name;
  int sensorTypeID;

  Sensor({
    this.id,
    this.name,
    this.sensorTypeID,
  });

  factory Sensor.fromJson(Map<String, dynamic> json) {
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
