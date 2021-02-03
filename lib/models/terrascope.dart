import 'package:intl/intl.dart';

class Terrascope {
  String url;
  DateTime date;
  bool loading;

  Terrascope({this.url, this.loading = true, this.date});

  factory Terrascope.fromJson(Map<String, dynamic> json) {
    return Terrascope(
      url: json['url'],
      date: json['date'] == null
          ? null
          : new DateFormat("yyyy-MM-dd").parse(json['date']),
    );
  }
}
