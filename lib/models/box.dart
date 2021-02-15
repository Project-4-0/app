import 'package:b_one_project_4_0/models/boxUser.dart';
import 'package:b_one_project_4_0/models/monitoring.dart';
import 'package:b_one_project_4_0/models/sensor.dart';
import 'package:b_one_project_4_0/models/user.dart';

class Box {
  int id;
  String macAddress;
  String name;
  String comment;
  bool active;
  BoxUser boxUser;
  List<Sensor> sensors;
  List<User> users;
  List<Monitoring> monitoring;

  Box(
      {this.id,
      this.macAddress,
      this.name,
      this.comment,
      this.active,
      this.boxUser,
      this.sensors,
      this.users,
      this.monitoring});

  factory Box.fromJson(Map<String, dynamic> json) {
    // print("monitoring length: " + json['monitoring']?.length.toString());
    if (json['monitoring'] == null) {
      return Box(
        id: json['BoxID'],
        macAddress: json['MacAddress'],
        name: json['Name'],
        comment: json['Comment'],
        active: json['Active'],
        boxUser:
            json['BoxUser'] == null ? null : BoxUser.fromJsonW(json['BoxUser']),
      );
    } else {
      return Box(
        id: json['BoxID'],
        macAddress: json['MacAddress'],
        name: json['Name'],
        comment: json['Comment'],
        active: json['Active'],
        boxUser:
            json['BoxUser'] == null ? null : BoxUser.fromJsonW(json['BoxUser']),
        monitoring:
            json['monitoring'] == null || json['monitoring']?.length == 0
                ? []
                : (json['monitoring'] as List)
                    .map((tagJson) => Monitoring.fromJson(tagJson))
                    .toList(),
      );
    }
  }

  factory Box.fromJsonAll(Map<String, dynamic> json) {
    return Box(
      id: json['BoxID'],
      macAddress: json['MacAddress'],
      name: json['Name'],
      comment: json['Comment'],
      active: json['Active'],
      boxUser:
          json['BoxUser'] == null ? null : BoxUser.fromJsonW(json['BoxUser']),
      sensors: json['sensors'] == null
          ? null
          : (json['sensors'] as List)
              .map((tagJson) => Sensor.fromJsonWithout(tagJson))
              .toList(),
      users: json['users'] == null
          ? null
          : (json['users'] as List)
              .map((tagJson) => User.fromJsonWithBoxUser(tagJson))
              .toList(), // TODO: What about boxUsers? !!!!!
      monitoring: json['monitoring'] == null
          ? null
          : (json['monitoring'] as List)
              .map((tagJson) => Monitoring.fromJson(tagJson))
              .toList(),
    );
  }

  factory Box.fromJsonW(Map<String, dynamic> json) {
    return Box(
        id: json['BoxID'],
        macAddress: json['MacAddress'],
        name: json['Name'],
        comment: json['Comment'],
        active: json['Active']);
  }

  Map<String, dynamic> toJson() => {
        'BoxID': id,
        'MacAddress': macAddress,
        'Name': name,
        'Comment': comment,
        'Active': active,
      };
}
