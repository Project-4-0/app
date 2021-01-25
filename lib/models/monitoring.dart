class Monitoring {
  int id;
  int boxID;
  String sdCapacity;
  bool batteryStatus;
  double batteryPercentage;
  DateTime endDate;

  Monitoring({
    this.id,
    this.boxID,
    this.sdCapacity,
    this.batteryStatus,
    this.batteryPercentage,
    this.endDate,
  });

  factory Monitoring.fromJson(Map<String, dynamic> json) {
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
