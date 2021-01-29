class Terrascope {
  String url;

  Terrascope({this.url});

  factory Terrascope.fromJson(Map<String, dynamic> json) {
    return Terrascope(
      url: json['url'],
    );
  }
}
