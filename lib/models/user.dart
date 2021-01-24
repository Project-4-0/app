class User {
  int id;
  String firstName;
  String lastName;
  String password;
  String email;
  String address;
  String posatlCode;
  String city;

  User({
    this.id,
    this.firstName,
    this.lastName,
    this.password,
    this.email,
    this.address,
    this.posatlCode,
    this.city,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['UserID'],
      firstName: json['FirstName'],
      lastName: json['LastName'],
      // password: json['Password'],
      email: json['Email'],
      address: json['Address'],
      posatlCode: json['PostalCode'],
      city: json['City'],
    );
  }

  Map<String, dynamic> toJson() => {
        'FirstName': firstName,
        'LastName': lastName,
        'password': password,
        'Email': email,
        'Address': address,
        'PostalCode': posatlCode,
        'City': city,
      };
}
