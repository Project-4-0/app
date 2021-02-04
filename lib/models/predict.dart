import 'package:intl/intl.dart';

class Predict {
  DateTime date;
  int boxID;
  num bodemvochtigheid;
  DateTime predictedatum;
  num mea;
  num rmsa;

  Predict(
      {this.date,
      this.boxID,
      this.bodemvochtigheid,
      this.predictedatum,
      this.mea,
      this.rmsa});

  factory Predict.fromJson(Map<String, dynamic> json) {
    return Predict(
      date: json['datum'] == null
          ? null
          : new DateFormat("yyyy-MM-dd").parse(json['datum']),
      // boxID: int.parse(json['boxID']),
      bodemvochtigheid:
          num.parse(num.parse(json['bodemvochtigheid']).toStringAsFixed(2)),
      predictedatum: json['predictedatum'] == null
          ? null
          : new DateFormat("yyyy-MM-dd").parse(json['predictedatum']),
      mea: num.parse(json['MEA']),
      rmsa: num.parse(json['RMSA']),
    );
  }
}
