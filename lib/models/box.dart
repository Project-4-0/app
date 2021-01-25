class Box {
  int id;
  String macAddress;
  String name;
  String comment;
  bool active;

  Box({this.id, this.macAddress, this.name, this.comment, this.active});

  factory Box.fromJson(Map<String, dynamic> json) {
    return Box(
      id: json['BoxID'],
      macAddress: json['MacAdress'],
      name: json['Name'],
      comment: json['Comment'],
      active: json['Active'],
    );
  }

  Map<String, dynamic> toJson() => {
        'MacAdress': macAddress,
        'Name': name,
        'Comment': comment,
        'Active': active,
      };
}
