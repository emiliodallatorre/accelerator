import 'dart:math';

import 'package:accelerator/references.dart';
import 'package:flutter/material.dart';
import 'package:ml_algo/ml_algo.dart';
import 'package:ml_dataframe/ml_dataframe.dart';
import 'package:sensors_plus/sensors_plus.dart';

class DataHelper {
  static const String columnName = "yAcceleration";

  final List<double> events;

  DataHelper(this.events);

  List<double> get lastValues => events.getRange(events.length - References.regressionSize, events.length).toList();

  List<Point<double>> get plainAccelerometer {
    List<Point<double>> data = <Point<double>>[];

    for (int index = 0; index < events.length; index++) {
      data.add(Point<double>(index.toDouble(), events.elementAt(index)));
    }

    return data;
  }

  DataFrame dataFrameFromList(List<double> data) => DataFrame(
        data.map((e) => [e]),
        header: [columnName],
      );

  /*List<Point<double>> get interceptData {
    List<Point<double>> data = <Point<double>>[];
    Iterable<double> regressedData = LinearRegressor(dataFrame, dataFrame.header.first).coefficients;

    for (int index = 0; index < regressedData.length; index++) {
      data.add(Point<double>(index.toDouble(), regressedData.elementAt(index)));
    }

    debugPrint("Sto facendo regressione.");
    return data;
  }*/

  List<Point<double>> get correlationData {
    debugPrint("Pronti a fare regressione lineare su ${lastValues.length} valori.");

    List<Point<double>> data = <Point<double>>[];
    for (int index = 0; index < lastValues.length; index++) {
      data.add(Point<double>(index.toDouble(), lastValues.elementAt(index) * lastValues.elementAt(index)));
    }

    return data;

    /* Iterable<double> regressedData = LinearRegressor(dataFrameFromList(lastValues), columnName)
        .coefficients;

    List<Point<double>> data = <Point<double>>[];
    for (int index = 0; index < regressedData.length; index++) {
      data.add(Point<double>(index.toDouble(), regressedData.elementAt(index)));
    }

    return data; */
  }
}
