class SensorType {
  int id;
  String name;
  String unit;

  SensorType({
    this.id,
    this.name,
    this.unit,
  });

  factory SensorType.fromJson(Map<String, dynamic> json) {
    return SensorType(
      id: json['SensorID'],
      name: json['Name'],
      unit: json['Unit'],
    );
  }

  Map<String, dynamic> toJson() => {
        'Name': name,
        'Unit': unit,
      };
}
