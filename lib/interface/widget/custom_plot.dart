import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_plot/flutter_plot.dart';

class CustomPlot extends StatelessWidget {
  final List<Point> data;
  final String xTitle, yTitle;

  const CustomPlot({Key? key, required this.data, required this.xTitle, required this.yTitle}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Plot(
      height: 200.0,
      data: data,
      gridSize: new Offset(2.0, 2.0),
      style: new PlotStyle(
        pointRadius: 3.0,
        outlineRadius: 1.0,
        primary: Colors.white,
        secondary: Colors.orange,
        textStyle: new TextStyle(
          fontSize: 8.0,
          color: Colors.blueGrey,
        ),
        axis: Colors.blueGrey[600],
        gridline: Colors.blueGrey[100],
      ),
      padding: const EdgeInsets.fromLTRB(40.0, 12.0, 12.0, 40.0),
      xTitle: xTitle,
      yTitle: yTitle,
    );
  }
}
