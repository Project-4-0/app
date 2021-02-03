class Kpi {
  int userCount;
  int boxCountActive;
  int boxCountNoneActive;

  Kpi({this.userCount, this.boxCountActive, this.boxCountNoneActive});

  factory Kpi.fromJson(Map<String, dynamic> json) {
    return Kpi(
      userCount: json['userCount'],
      boxCountActive: json['boxCountActive'],
      boxCountNoneActive: json['boxCountNoneActive'],
    );
  }
}
