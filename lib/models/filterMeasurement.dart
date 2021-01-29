class FilterMeasurement {
  DateTime startDate;
  DateTime endDate;
  int boxID;
  int userID;

  FilterMeasurement({
    this.startDate,
    this.endDate,
    this.boxID,
    this.userID,
  });

  // factory FilterMeasurement.fromJson(Map<String, dynamic> json) {
  //   return FilterMeasurement(
  //      startDate: DateTime.parse(json['startDate']),
  //       endDate: DateTime.parse(json['endDate']),
  //     id: json['FilterMeasurementID'],
  //     boxID: json['BoxID'],
  //     sensorID: json['SensorID'],
  //     value: json['Value'],
  //     startDate: DateTime.parse(json['TimeStamp']),
  //   );
  // }

  Map<String, dynamic> toJson() => {
        'StartDate': startDate,
        'EndDate': endDate,
        'BoxID': boxID,
        'UserID': userID,
      };
}
