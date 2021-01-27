import 'package:b_one_project_4_0/models/boxUser.dart';

class Box {
  int id;
  String macAddress;
  String name;
  String comment;
  bool active;
  BoxUser boxUser;

  Box({this.id, this.macAddress, this.name, this.comment, this.active, this.boxUser});

  factory Box.fromJson(Map<String, dynamic> json) {
    return Box(
      id: json['BoxID'],
      macAddress: json['MacAdress'],
      name: json['Name'],
      comment: json['Comment'],
      active: json['Active'],
            boxUser:
          json['BoxUser'] == null ? null : BoxUser.fromJsonW(json['BoxUser']),
    );
  }

  Map<String, dynamic> toJson() => {
        'MacAdress': macAddress,
        'Name': name,
        'Comment': comment,
        'Active': active,
      };
}
