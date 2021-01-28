import 'package:b_one_project_4_0/models/userType.dart';
import 'package:b_one_project_4_0/models/box.dart';

class User {
  int id;
  String firstName;
  String lastName;
  String email;
  String password;
  String address;
  String postalCode;
  String city;
  int userTypeID;
  UserType userType;
  List<Box> boxes;

  User(
      {this.id,
      this.firstName,
      this.lastName,
      this.email,
      this.password,
      this.address,
      this.postalCode,
      this.city,
      this.userTypeID,
      this.userType,
      this.boxes});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['UserID'],
      firstName: json['FirstName'],
      lastName: json['LastName'],
      email: json['Email'],
      address: json['Address'],
      postalCode: json['PostalCode'],
      city: json['City'],
      userTypeID: json['UserTypeID'],
      userType:
          json['UserType'] == null ? null : UserType.fromJson(json['UserType']),
    );
  }

  // Without extra boxes included
  factory User.fromJsonWithBoxes(Map<String, dynamic> json) {
    return User(
      id: json['UserID'],
      firstName: json['FirstName'],
      lastName: json['LastName'],
      email: json['Email'],
      address: json['Address'],
      postalCode: json['PostalCode'],
      city: json['City'],
      userTypeID: json['UserTypeID'],
      userType:
          json['UserType'] == null ? null : UserType.fromJson(json['UserType']),
      boxes: (json['boxes'] as List)
          .map((tagJson) => Box.fromJson(tagJson))
          .toList(),
    );
  }

  // Without extra tables included
  factory User.fromJsonW(Map<String, dynamic> json) {
    return User(
      id: json['UserID'],
      firstName: json['FirstName'],
      lastName: json['LastName'],
      email: json['Email'],
      address: json['Address'],
      postalCode: json['PostalCode'],
      city: json['City'],
      userTypeID: json['UserTypeID'],
    );
  }

  Map<String, dynamic> toJson() => {
        'UserID': id,
        'FirstName': firstName,
        'LastName': lastName,
        'Email': email,
        'Password': password,
        'Address': address,
        'PostalCode': postalCode,
        'City': city,
        'UserTypeID': userTypeID,
        'UserType': userType,
      };

  Map<String, dynamic> toJsonWithout() => {
        'UserID': id,
        'FirstName': firstName,
        'LastName': lastName,
        'Email': email,
        'Password': password,
        'Address': address,
        'PostalCode': postalCode,
        'City': city,
      };
}
