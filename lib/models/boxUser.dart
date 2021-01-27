import 'package:b_one_project_4_0/models/box.dart';
import 'package:b_one_project_4_0/models/user.dart';

class BoxUser {
  int id;
  int boxID;
  int userID;
  DateTime startDate;
  DateTime endDate;
  User user;
  Box box;

  BoxUser(
      {this.id,
      this.boxID,
      this.userID,
      this.startDate,
      this.endDate,
      this.user,
      this.box});

  factory BoxUser.fromJson(Map<String, dynamic> json) {
    return BoxUser(
        id: json['BoxUserID'],
        boxID: json['BoxID'],
        userID: json['UserID'],
        // startDate: json['StartDate'],
        startDate: DateTime.tryParse(json['StartDate']),
        endDate: DateTime.tryParse(json['EndDate']),
        user: User.fromJson(json['User']),
        box: Box.fromJson(json['Box']));
  }

  // Without extra tables included
  factory BoxUser.fromJsonW(Map<String, dynamic> json) {
    return BoxUser(
        id: json['BoxUserID'],
        boxID: json['BoxID'],
        userID: json['UserID'],
        startDate: DateTime.tryParse(json['StartDate']),
        endDate: DateTime.tryParse(json['EndDate']));
  }

  Map<String, dynamic> toJson() => {
        'BoxID': boxID,
        'UserID': userID,
        'StartDate': startDate,
        'EndDate': endDate,
      };
}
