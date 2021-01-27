import 'package:b_one_project_4_0/models/measurement.dart';
import 'package:b_one_project_4_0/models/measurementGraphics.dart';
import 'package:b_one_project_4_0/widgets/buttons/IconTextLeftButton.dart';
import 'package:b_one_project_4_0/widgets/TextFieldBOne.dart';
import 'package:b_one_project_4_0/widgets/charts/StackedAreacLineChart.dart';
import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;

// Default design button BOne
class StackAreacLineChartBone extends StatelessWidget {
  const StackAreacLineChartBone({
    Key key,
    @required this.measurementGraphics,
  }) : super(key: key);

  final MeasurementGraphics measurementGraphics;

  @override
  Widget build(BuildContext context) {
    if (measurementGraphics == null) {
      return Text("loading");
    }

    return new charts.TimeSeriesChart(
      _transformBuildDate(),
      defaultRenderer:
          new charts.LineRendererConfig(includeArea: true, stacked: true),
      animate: false,
      dateTimeFactory: const charts.LocalDateTimeFactory(),
    );

    return StackedAreaLineChart(_transformBuildDate());
  }

  List<charts.Series<TimeSeriesSales, DateTime>> _transformBuildDate() {
    var myFakeDesktopData = List<TimeSeriesSales>();
    // Alle boxen
    var boxendata = List<charts.Series<TimeSeriesSales, DateTime>>();

    //foreach boxen get Graph
    this.measurementGraphics.boxes.forEach((box) {
      for (int i = 0;
          i < this.measurementGraphics.measurementsList.length;
          i++) {
        myFakeDesktopData.add(
          new TimeSeriesSales(
              this.measurementGraphics.measurementsList[i].timeStamp,
              double.parse(this.measurementGraphics.measurementsList[i].value)),
        );
      }

      //add diferen graph
      boxendata.add(
        new charts.Series<TimeSeriesSales, DateTime>(
          id: box.name,
          colorFn: (_, __) => charts.MaterialPalette.blue.shadeDefault,
          domainFn: (TimeSeriesSales sales, _) => sales.time,
          measureFn: (TimeSeriesSales sales, _) => sales.value,
          data: myFakeDesktopData,
        ),
      );
    });

    //return all boxen graph
    return boxendata;
  }
}

// get color
_getRadomColor() {}

/// Sample linear data type.
class TimeSeriesSales {
  final DateTime time;
  final num value;

  TimeSeriesSales(this.time, this.value);
}
