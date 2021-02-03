import 'package:intl/intl.dart';

class Predict {
  DateTime date;
  int boxID;
  double bodemvochtigheid;
  DateTime predictedatum;
  double mea;
  double rmsa;

  Predict({this.date, this.boxID,this.bodemvochtigheid,this.predictedatum, this.mea,this.rmsa});

  factory Predict.fromJson(Map<String, dynamic> json) {
    return Predict(
      date: json['datum'] == null
            ? null
            : new DateFormat("yyyy-MM-dd").parse(json['datum']),
      // boxID: int.parse(json['boxID']),
      bodemvochtigheid: double.parse(json['bodemvochtigheid']),
      predictedatum: json['predictedatum'] == null
            ? null
            : new DateFormat("yyyy-MM-dd").parse(json['predictedatum']),
      mea: double.parse(json['MEA']),
      rmsa: double.parse(json['RMSA']),
    );
  }
}
