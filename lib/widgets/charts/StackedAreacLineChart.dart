import 'package:b_one_project_4_0/models/measurement.dart';

/// Example of a stacked area chart.
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';

class StackedAreaLineChart extends StatelessWidget {
  final List<charts.Series> seriesList;
  final bool animate;

  StackedAreaLineChart(this.seriesList, {this.animate});

  // /// Creates a [LineChart] with sample data and no transition.
  // factory StackedAreaLineChart.withSampleData() {
  //   return new StackedAreaLineChart(
  //     _createSampleData(),
  //     // Disable animations for image tests.
  //     animate: false,
  //   );
  // }

  // factory StackedAreaLineChart.sendata(List<Measurement> measurement) {
  //   return new StackedAreaLineChart(
  //     _createSampleData(measurement),
  //     // Disable animations for image tests.
  //     animate: true,
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    return new charts.LineChart(seriesList,
        defaultRenderer:
            new charts.LineRendererConfig(includeArea: true, stacked: true),
        animate: animate);
  }
}
