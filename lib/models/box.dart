import 'package:b_one_project_4_0/models/boxUser.dart';
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

  Box(
      {this.id,
      this.macAddress,
      this.name,
      this.comment,
      this.active,
      this.boxUser,
      this.sensors,
      this.users});

  factory Box.fromJson(Map<String, dynamic> json) {
    return Box(
      id: json['BoxID'],
      macAddress: json['MacAddress'],
      name: json['Name'],
      comment: json['Comment'],
      active: json['Active'],
      boxUser:
          json['BoxUser'] == null ? null : BoxUser.fromJsonW(json['BoxUser']),
    );
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
      sensors: (json['sensors'] as List)
          .map((tagJson) => Sensor.fromJsonWithout(tagJson))
          .toList(),
      users: (json['users'] as List)
          .map((tagJson) => User.fromJsonWithBoxUser(tagJson))
          .toList(), // TODO: What about boxUsers? !!!!!
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
