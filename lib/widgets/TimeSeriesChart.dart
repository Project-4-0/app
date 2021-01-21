// Timeseries chart example
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';

class TimeSeriesChart extends StatelessWidget {
  final List<charts.Series> seriesList;
  final bool animate;
  final String title;
  final String subTitle;
  final String unit;
  final Color lineColor;
  final meassureAxisValues;

  TimeSeriesChart(this.seriesList,
      {this.animate,
      this.title,
      this.subTitle,
      this.unit,
      this.lineColor,
      this.meassureAxisValues});
  // Creates a chart with sample data and no transition.
  factory TimeSeriesChart.withSampleData(
      {String title,
      String subTitle,
      bool animate,
      String unit,
      Color lineColor,
      meassureAxisValues}) {
    return new TimeSeriesChart(
      _createSampleData(lineColor),
      title: title,
      subTitle: subTitle,
      animate: animate,
      unit: unit,
      lineColor: lineColor,
      meassureAxisValues: meassureAxisValues,
    );
  }

  @override
  Widget build(BuildContext context) {
    /// Formatter for numeric ticks that uses the callback provided.
    ///
    /// Use this formatter if you need to format values that [NumberFormat]
    /// cannot provide.
    ///
    // / To see this formatter, change [NumericAxisSpec] to use this formatter.
    final customTickFormatter = charts.BasicNumericTickFormatterSpec(
        (num value) => '$value' + this.unit);

    return new charts.TimeSeriesChart(
      seriesList,
      animate: this.animate,
      // Configures a [PercentInjector] behavior that will calculate measure
      // values as the percentage of the total of all data in its series
      behaviors: [
        new charts.ChartTitle(
          this.title,
          subTitle: this.subTitle != null ? this.subTitle : null,
          behaviorPosition: charts.BehaviorPosition.top,
          titleOutsideJustification: charts.OutsideJustification.start,
          innerPadding: 18,
        ),
        // TODO: gemiddelde berekenen van een bepaalde periode
        new charts.ChartTitle('Gemiddelde ... - ... :',
            behaviorPosition: charts.BehaviorPosition.bottom,
            titleOutsideJustification:
                charts.OutsideJustification.middleDrawArea),
        new charts.PanAndZoomBehavior(),
      ],
      selectionModels: [
        charts.SelectionModelConfig(
            changedListener: (charts.SelectionModel model) {
          if (model.hasDatumSelection)
            print(model.selectedSeries[0]
                .measureFn(model.selectedDatum[0].index));
        })
      ],
      // Configure the axis spec to show percentage values.
      primaryMeasureAxis: new charts.NumericAxisSpec(
          renderSpec: new charts.GridlineRendererSpec(
            // labelAnchor: charts.TickLabelAnchor.before,
            labelJustification: charts.TickLabelJustification.outside,
          ),
          tickFormatterSpec: customTickFormatter,
          // Custom  tick values from parent
          tickProviderSpec: new charts.StaticNumericTickProviderSpec([
            for (var i in meassureAxisValues) charts.TickSpec(i),
          ])),
      dateTimeFactory: const charts.LocalDateTimeFactory(),
      domainAxis: charts.DateTimeAxisSpec(
        tickFormatterSpec: charts.AutoDateTimeTickFormatterSpec(
          day: charts.TimeFormatterSpec(
            format: 'dd/MM',
            transitionFormat: 'dd/MM',
          ),
        ),
      ),
    );
  }

  // Create one series with sample hard coded data.
  static List<charts.Series<TimeSeries, DateTime>> _createSampleData(
      Color lineColor) {
    final data = [
      new TimeSeries(new DateTime(2020, 9, 19), 5.0),
      new TimeSeries(new DateTime(2020, 9, 20), 25.0),
      new TimeSeries(new DateTime(2020, 9, 21), 30.0),
      new TimeSeries(new DateTime(2020, 9, 22), 95.0),
      new TimeSeries(new DateTime(2020, 9, 23), 99.0),
      new TimeSeries(new DateTime(2020, 9, 24), 33.5),
      new TimeSeries(new DateTime(2020, 9, 25), 15.0),
      new TimeSeries(new DateTime(2020, 9, 26), 20.0),
    ];

    return [
      new charts.Series<TimeSeries, DateTime>(
        id: 'Chart',
        // colorFn: (_, __) => charts.MaterialPalette.red.shadeDefault,
        colorFn: (_, __) => charts.ColorUtil.fromDartColor(lineColor),
        domainFn: (TimeSeries chart, _) => chart.time,
        measureFn: (TimeSeries chart, _) => chart.value,
        // The line renderer will render the area around the bounds. (Some clearance)
        measureLowerBoundFn: (TimeSeries chart, _) => chart.value - 1.0,
        measureUpperBoundFn: (TimeSeries chart, _) => chart.value + 1.0,
        data: data,
      )
    ];
  }
}

// Sample time series data type.
class TimeSeries {
  final DateTime time;
  final double value;

  TimeSeries(this.time, this.value);
}
