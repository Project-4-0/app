import 'package:b_one_project_4_0/models/userType.dart';

class User {
  int id;
  String firstName;
  String lastName;
  String email;
  String address;
  String posatlCode;
  String city;
  int userTypeID;
  UserType userType;

  User({
    this.id,
    this.firstName,
    this.lastName,
    this.email,
    this.address,
    this.posatlCode,
    this.city,
    this.userTypeID,
    this.userType,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['UserID'],
      firstName: json['FirstName'],
      lastName: json['LastName'],
      email: json['Email'],
      address: json['Address'],
      posatlCode: json['PostalCode'],
      city: json['City'],
      userTypeID: json['UserTypeID'],
      userType: UserType.fromJson(json['UserType']),
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
      posatlCode: json['PostalCode'],
      city: json['City'],
      userTypeID: json['UserTypeID'],
    );
  }

  Map<String, dynamic> toJson() => {
        'FirstName': firstName,
        'LastName': lastName,
        'Email': email,
        'Address': address,
        'PostalCode': posatlCode,
        'City': city,
        'UserTypeID': userTypeID,
        'UserType': userType,
      };
}
