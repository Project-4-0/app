import 'dart:math';
import 'package:b_one_project_4_0/models/measurementGraphics.dart';
import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;

// Default design button BOne
class StackAreacLineChartBone extends StatelessWidget {
  const StackAreacLineChartBone({
    Key key,
    @required this.measurementGraphics,
    @required this.title,
  }) : super(key: key);

  final MeasurementGraphics measurementGraphics;
  final String title;

  @override
  Widget build(BuildContext context) {
    if (measurementGraphics == null) {
      return Text("loading");
    }
    return Column(
      children: [
        Text(
          this.title,
          style: TextStyle(fontSize: 25),
        ),
        SizedBox(
          width: double.infinity,
          height: 250.0,
          child: new charts.TimeSeriesChart(
            _transformBuildDate(),
            defaultRenderer: new charts.LineRendererConfig(
                includeArea: true, stacked: false),
            animate: false,
            dateTimeFactory: const charts.LocalDateTimeFactory(),
          ),
        ),
      ],
    );
  }

  List<charts.Series<TimeSeriesSales, DateTime>> _transformBuildDate() {
    var myFakeDesktopData = List<TimeSeriesSales>();
    // Alle boxen
    var boxendata = List<charts.Series<TimeSeriesSales, DateTime>>();

    //foreach boxen get Graph
    this.measurementGraphics.boxes.forEach((box) {
      var col = _getRadomColor();
      myFakeDesktopData = List<TimeSeriesSales>();
      for (int i = 0;
          i < this.measurementGraphics.measurementsList.length;
          i++) {
        if (box.id == this.measurementGraphics.measurementsList[i].boxID) {
          // print(this.measurementGraphics.measurementsList[i].boxID);
          // print(this.measurementGraphics.measurementsList[i].value);
          myFakeDesktopData.add(
            new TimeSeriesSales(
                this.measurementGraphics.measurementsList[i].timeStamp,
                double.parse(
                    this.measurementGraphics.measurementsList[i].value)),
          );
        }
      }

      //add diferen graph
      boxendata.add(
        new charts.Series<TimeSeriesSales, DateTime>(
          id: box.name,
          colorFn: (_, __) => col,
          domainFn: (TimeSeriesSales sales, _) => sales.time,
          measureFn: (TimeSeriesSales sales, _) => sales.value,
          data: myFakeDesktopData,
        ),
      );
    });

    //return all boxen graph
    return boxendata;
  }

  // get color
  _getRadomColor() {
    Random random = new Random();
    int colorCounter = random.nextInt(3);
    switch (colorCounter) {
      case 1:
        return charts.MaterialPalette.blue.shadeDefault;
      case 2:
        return charts.MaterialPalette.red.shadeDefault;
      case 3:
        return charts.MaterialPalette.green.shadeDefault;
      default:
        return charts.MaterialPalette.green.shadeDefault;
    }
  }
}

/// Sample linear data type.
class TimeSeriesSales {
  final DateTime time;
  final num value;

  TimeSeriesSales(this.time, this.value);
}
