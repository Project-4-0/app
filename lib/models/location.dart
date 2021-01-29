import 'package:b_one_project_4_0/models/boxUser.dart';

class Location {
  int id;
  String boxUserID;
  String latitude;
  String longitude;
  DateTime startDate;
  DateTime endDate;
  BoxUser boxUser;

  Location(
      {this.id,
      this.boxUserID,
      this.latitude,
      this.longitude,
      this.startDate,
      this.endDate,
      this.boxUser});

  factory Location.fromJson(Map<String, dynamic> json) {
    return Location(
      id: json['LocationID'],
      boxUserID: json['BoxUserID'],
      latitude: json['Latitude'],
      longitude: json['Longitude'],
      startDate: json['StartDate'] == null ? null : json['StartDate'],
      endDate: json['EndDate'] == null ? null : json['EndDate'],
      boxUser:
          json['BoxUser'] == null ? null : BoxUser.fromJson(json['BoxUser']),
    );
  }

  // Without extra tables included
  factory Location.fromJsonW(Map<String, dynamic> json) {
    return Location(
        id: json['LocationID'],
        boxUserID: json['BoxUserID'],
        latitude: json['Latitude'],
        longitude: json['Longitude'],
        startDate: json['StartDate'] == null ? null : json['StartDate'],
        endDate: json['EndDate'] == null ? null : json['EndDate']);
  }

  Map<String, dynamic> toJson() => {
        'BoxUserID': boxUserID,
        'Latitude': latitude,
        'Longitude': longitude,
        'StartDate': startDate,
        'EndDate': endDate,
      };
}
