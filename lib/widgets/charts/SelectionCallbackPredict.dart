import 'package:b_one_project_4_0/models/predict.dart';
import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:intl/intl.dart';
import 'package:stats/stats.dart';

class SelectionCallbackPredict extends StatefulWidget {
  const SelectionCallbackPredict({
    Key key,
    @required this.predictList,
    @required this.title,
  }) : super(key: key);

  final List<Predict> predictList;
  final String title;

  @override
  _SelectionCallbackState createState() => _SelectionCallbackState();
}

class _SelectionCallbackState extends State<SelectionCallbackPredict> {
  DateTime _time;
  Map<String, num> _measures;

  // Listens to the underlying selection changes, and updates the information
  // relevant to building the primitive legend like information under the
  // chart.
  _onSelectionChanged(charts.SelectionModel model) {
    final selectedDatum = model.selectedDatum;

    DateTime time;
    final measures = <String, num>{};

    // We get the model that updated with a list of [SeriesDatum] which is
    // simply a pair of series & datum.
    //
    // Walk the selection updating the measures map, storing off the sales and
    // series name for each selection point.
    if (selectedDatum.isNotEmpty) {
      time = selectedDatum.first.datum.time;
      selectedDatum.forEach((charts.SeriesDatum datumPair) {
        measures[datumPair.series.displayName] = datumPair.datum.sales;
      });
    }

    // Request a build.
    setState(() {
      _time = time;
      _measures = measures;
    });
  }

  @override
  Widget build(BuildContext context) {
    // The children consist of a Chart and Text widgets below to hold the info.

    

    final children = <Widget>[
      Text(
        this.widget.title,
        style: TextStyle(fontSize: 25, color: Colors.black),
      ),
      SizedBox(
        height: 20,
      ),
    ];

   if (this.widget.predictList.isEmpty) {
     children.add(Text("Geen gegevens beschikbaar"));
      return new Column(children: children);
    }
    children.add(_forOneGraphicTop());
    children.add(
      SizedBox(
        height: 20,
      ),
    );

    children.add(
      new SizedBox(
          height: 150.0,
          child: new charts.TimeSeriesChart(
            _transformBuildDate(),
            animate: false,
            selectionModels: [
              new charts.SelectionModelConfig(
                type: charts.SelectionModelType.info,
                changedListener: _onSelectionChanged,
              )
            ],
          )),
    );

    // If there is a selection, then include the details.
    // if (_time != null) {
    //   children.add(new Padding(
    //       padding: new EdgeInsets.only(top: 5.0),
    //       child: new Text(_time.toString())));
    // }
    // _measures?.forEach((String series, num value) {
    //   children.add(new Text('${series}: ${value}'));
    // });

    return new Column(children: children);
  }

  _forOneGraphicTop() {
    if (_time == null) {
      return Column();
    }

    print(_measures);

    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Text(
              "Datum : " + DateFormat('dd-MM-yyyy').format(_time),
              style: TextStyle(fontSize: 13),
            ),
            Text(
              "Bodemvochtigheid : " + _measures["Bodemvochtigheid"].toString(),
              style: TextStyle(fontSize: 13),
            ),
            // Text(
            //   "Afwijking : " +
            //       num.parse((_measures["Mea"] - _measures["Bodemvochtigheid"])
            //               .toStringAsFixed(2))
            //           .abs()
            //           .toString(),
            //   style: TextStyle(fontSize: 13),
            // ),
          ],
        ),
        // Row(
        //   mainAxisAlignment: MainAxisAlignment.start,
        //   children: [
        //     Text(
        //       "Bodemvochtigheid : " + _measures["Bodemvochtigheid"].toString(),
        //       style: TextStyle(fontSize: 13),
        //     ),
        //     // Text(
        //     //   "Max. : " + stat.max.toString(),
        //     //   style: TextStyle(fontSize: 13),
        //     // ),
        //   ],
        // ),
      ],
    );
  }

  /// Create one series with sample hard coded data.
  List<charts.Series<TimeSeriesSales, DateTime>> _transformBuildDate() {
    var predictData = List<TimeSeriesSales>();
    var meaMaxData = List<TimeSeriesSales>();
    var meaMinData = List<TimeSeriesSales>();

    this.widget.predictList.forEach((predict) {
      var mea = predict.bodemvochtigheid;
      predictData.add(
          new TimeSeriesSales(predict.predictedatum, predict.bodemvochtigheid));
      meaMaxData.add(new TimeSeriesSales(predict.predictedatum, mea));
      // meaMaxData.add(new TimeSeriesSales(
      //     predict.predictedatum,
      //     num.parse(
      //         (predict.bodemvochtigheid + predict.mea).toStringAsFixed(2))));
      // meaMinData.add(new TimeSeriesSales(
      //     predict.predictedatum,
      //     num.parse(
      //         (predict.bodemvochtigheid - predict.mea).toStringAsFixed(2))));
    });

    return [
      new charts.Series<TimeSeriesSales, DateTime>(
        id: 'Mea',
        domainFn: (TimeSeriesSales sales, _) => sales.time,
        measureFn: (TimeSeriesSales sales, _) => sales.sales,
        data: meaMaxData,
        strokeWidthPxFn: (TimeSeriesSales sales, _) => sales.sales,
        colorFn: (_, __) => charts.MaterialPalette.gray.shade300,
      ),
      new charts.Series<TimeSeriesSales, DateTime>(
        id: 'Bodemvochtigheid',
        domainFn: (TimeSeriesSales sales, _) => sales.time,
        measureFn: (TimeSeriesSales sales, _) => sales.sales,
        data: predictData,
        strokeWidthPxFn: (TimeSeriesSales sales, _) => 2,
      ),

      // new charts.Series<TimeSeriesSales, DateTime>(
      //   id: 'Mea',
      //   domainFn: (TimeSeriesSales sales, _) => sales.time,
      //   measureFn: (TimeSeriesSales sales, _) => sales.sales,
      //   data: meaMinData,
      //   colorFn: (_, __) => charts.MaterialPalette.gray.shade300,
      // ),
    ];
  }
}

/// Sample time series data type.
class TimeSeriesSales {
  final DateTime time;
  final num sales;

  TimeSeriesSales(this.time, this.sales);
}
