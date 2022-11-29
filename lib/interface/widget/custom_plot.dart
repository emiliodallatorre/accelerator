import 'dart:math';

import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class CustomPlot extends StatelessWidget {
  final List<Point> data;
  final String xTitle, yTitle;

  const CustomPlot({Key? key, required this.data, required this.xTitle, required this.yTitle}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SfCartesianChart(
      primaryXAxis: NumericAxis(
        title: AxisTitle(text: xTitle),
      ),
      primaryYAxis: NumericAxis(
        title: AxisTitle(text: yTitle),
      ),
      series: <ChartSeries>[
        LineSeries<Point, double>(
          dataSource: data,
          xValueMapper: (Point point, _) => point.x.toDouble(),
          yValueMapper: (Point point, _) => point.y,
        ),
      ],
    );
  }
}
