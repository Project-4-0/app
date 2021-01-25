/*
Other model interface for registration 
The only different between User and Registration is without password 
With User you can't send password

Json Auth server, password are hashed!
*/
class UserRegistration {
  int id;
  String email;
  String firstname;
  String lastname;
  String password;

  UserRegistration(
      {this.id, this.email, this.firstname, this.lastname, this.password});

  // factory UserRegistration.fromJson(Map<String, dynamic> json) {
  //   return UserRegistration(
  //     id: json['id'],
  //     email: json['email'],
  //     firstname: json['first_name'],
  //     lastname: json['last_name'],
  //     password: json['password'],
  //   );
  // }

  Map<String, dynamic> toJson() => {
        'id': id,
        'email': email,
        'first_name': firstname,
        'last_name': lastname,
        'password': password,
      };
}
