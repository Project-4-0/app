import 'dart:math';
import 'package:b_one_project_4_0/models/measurementGraphics.dart';
import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;

// Default design button BOne
class StackAreacLineChartBone extends StatefulWidget {
  const StackAreacLineChartBone({
    Key key,
    @required this.measurementGraphics,
    @required this.title,
  }) : super(key: key);

  final MeasurementGraphics measurementGraphics;
  final String title;

  @override
  _StackAreacLineChartBoneState createState() =>
      _StackAreacLineChartBoneState();
}

class _StackAreacLineChartBoneState extends State<StackAreacLineChartBone> {
  @override
  Widget build(BuildContext context) {
    if (widget.measurementGraphics == null) {
      return Text("loading");
    }
    return Column(
      children: [
        Text(
          this.widget.title,
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
            behaviors: [
              new charts.SeriesLegend(
                // Positions for "start" and "end" will be left and right respectively
                // for widgets with a build context that has directionality ltr.
                // For rtl, "start" and "end" will be right and left respectively.
                // Since this example has directionality of ltr, the legend is
                // positioned on the right side of the chart.
                position: charts.BehaviorPosition.bottom,
                // For a legend that is positioned on the left or right of the chart,
                // setting the justification for [endDrawArea] is aligned to the
                // bottom of the chart draw area.
                outsideJustification: charts.OutsideJustification.endDrawArea,
                // By default, if the position of the chart is on the left or right of
                // the chart, [horizontalFirst] is set to false. This means that the
                // legend entries will grow as new rows first instead of a new column.
                horizontalFirst: false,
                // By setting this value to 2, the legend entries will grow up to two
                // rows before adding a new column.
                desiredMaxRows: 2,
                // This defines the padding around each legend entry.
                cellPadding: new EdgeInsets.only(right: 4.0, bottom: 4.0),
                // Render the legend entry text with custom styles.
                entryTextStyle: charts.TextStyleSpec(fontSize: 11),
              )
            ],
          ),
        ),
      ],
    );
  }

  int colorCounter = 0;
  _getRadomColor() {
    // Random random = new Random();
    // int colorCounter = random.nextInt(3);
    colorCounter += 1;
    switch (colorCounter) {
      case 0:
        return charts.MaterialPalette.gray.shadeDefault;
      case 1:
        return charts.MaterialPalette.blue.shadeDefault;
      case 2:
        return charts.MaterialPalette.red.shadeDefault;
      case 3:
        return charts.MaterialPalette.green.shadeDefault;
      case 4:
        return charts.MaterialPalette.gray.shadeDefault;
      case 5:
        return charts.MaterialPalette.green.shadeDefault;
      case 6:
        return charts.MaterialPalette.purple.shadeDefault;
      default:
        return charts.MaterialPalette.green.shadeDefault;
    }
  }

  List<charts.Series<TimeSeriesSales, DateTime>> _transformBuildDate() {
    var myFakeDesktopData = List<TimeSeriesSales>();
    // Alle boxen
    var boxendata = List<charts.Series<TimeSeriesSales, DateTime>>();

    //reset color
    colorCounter = 0;

    //foreach boxen get Graph
    this.widget.measurementGraphics.boxes.forEach((box) {
      var col = _getRadomColor();
      myFakeDesktopData = List<TimeSeriesSales>();
      for (int i = 0;
          i < this.widget.measurementGraphics.measurementsList.length;
          i++) {
        if (box.id ==
            this.widget.measurementGraphics.measurementsList[i].boxID) {
          // print(this.measurementGraphics.measurementsList[i].boxID);
          // print(this.measurementGraphics.measurementsList[i].value);
          myFakeDesktopData.add(
            new TimeSeriesSales(
                this.widget.measurementGraphics.measurementsList[i].timeStamp,
                double.parse(
                    this.widget.measurementGraphics.measurementsList[i].value)),
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
}

/// Sample linear data type.
class TimeSeriesSales {
  final DateTime time;
  final num value;

  TimeSeriesSales(this.time, this.value);
}
