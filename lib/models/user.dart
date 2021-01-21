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
      id: json['id'],
      firstName: json['first_name'],
      lastName: json['last_name'],
      password: json['password'],
      email: json['email'],
      address: json['address'],
      posatlCode: json['postal_code'],
      city: json['city'],
    );
  }

  Map<String, dynamic> toJson() => {
        'first_name': firstName,
        'last_name': lastName,
        'password': password,
        'email': email,
        'address': address,
        'posatlCode': posatlCode,
        'city': city,
      };
}
