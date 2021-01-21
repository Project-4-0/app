class Box {
  int id;
  String macAddress;
  String name;
  String comment;
  bool active;
// ...

  Box({
    this.id,
    this.macAddress,
    this.name,
    this.comment,
    this.active,
// ...
  });

  factory Box.fromJson(Map<String, dynamic> json) {
    return Box(
      id: json['id'],
      macAddress: json['mac_address'],
      name: json['name'],
      comment: json['comment'],
      active: json['active'],
    );
  }

  Map<String, dynamic> toJson() => {
        'macAddress': macAddress,
        'name': name,
        'comment': comment,
        'active': active,
      };
}
