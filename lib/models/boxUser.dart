class BoxUser {
  int id;
  String boxID;
  String userID;
  DateTime startDate;
  DateTime endDate;

  BoxUser({
    this.id,
    this.boxID,
    this.userID,
    this.startDate,
    this.endDate,
  });

  factory BoxUser.fromJson(Map<String, dynamic> json) {
    return BoxUser(
      id: json['BoxUserID'],
      boxID: json['BoxID'],
      userID: json['UserID'],
      startDate: json['StartDate'],
      endDate: json['EndDate'],
    );
  }

  Map<String, dynamic> toJson() => {
        'BoxID': boxID,
        'UserID': userID,
        'StartDate': startDate,
        'EndDate': endDate,
      };
}
