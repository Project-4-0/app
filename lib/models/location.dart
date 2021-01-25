class Location {
  int id;
  String boxUserID;
  String latitude;
  String longitude;
  DateTime startDate;
  DateTime endDate;

  Location({
    this.id,
    this.boxUserID,
    this.latitude,
    this.longitude,
    this.startDate,
    this.endDate,
  });

  factory Location.fromJson(Map<String, dynamic> json) {
    return Location(
      id: json['LocationID'],
      boxUserID: json['BoxUserID'],
      latitude: json['Latitude'],
      longitude: json['Longitude'],
      startDate: json['StartDate'],
      endDate: json['EndDate'],
    );
  }

  Map<String, dynamic> toJson() => {
        'BoxUserID': boxUserID,
        'Latitude': latitude,
        'Longitude': longitude,
        'StartDate': startDate,
        'EndDate': endDate,
      };
}
