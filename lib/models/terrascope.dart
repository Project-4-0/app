class Terrascope {
  String url;
  bool loading;

  Terrascope({this.url, this.loading = true});

  factory Terrascope.fromJson(Map<String, dynamic> json) {
    return Terrascope(
      url: json['url'],
    );
  }
}
