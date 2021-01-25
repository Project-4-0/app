class UserType {
  int id;
  String userTypeName;

  UserType({
    this.id,
    this.userTypeName,
  });

  factory UserType.fromJson(Map<String, dynamic> json) {
    return UserType(
      id: json['UserID'],
      userTypeName: json['UserTypeName'],
    );
  }

  Map<String, dynamic> toJson() => {
        'UserTypeName': userTypeName,
      };
}
