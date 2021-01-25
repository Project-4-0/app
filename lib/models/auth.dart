class Auth {
  int userID;
  String token;

  Auth({this.userID, this.token});

  factory Auth.fromJson(Map<String, dynamic> json) {
    return Auth(
      userID: json['UserID'],
      token: json['Token'],
    );
  }
}
