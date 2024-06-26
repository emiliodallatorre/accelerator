import 'dart:math';

import 'package:accelerator/references.dart';
import 'package:flutter/material.dart';

class LogDataStructure {
  final Map<int, double> accelerationValues = <int, double>{};
  final Map<int, double> correlationValues = <int, double>{};

  List<Point> get accelerationPoints => mapToPoints(accelerationValues);

  List<Point> get correlationPoints => mapToPoints(correlationValues);

  DateTime? startDateTime;

  void addObservation(final DateTime date, final double value) {
    startDateTime ??= date;

    accelerationValues[date.difference(startDateTime!).inMilliseconds] = value;

    while (accelerationValues.length > References.samplingRate * 1) {
      List<int> sortedValues = accelerationValues.keys.toList()..sort();
      // debugPrint(sortedValues.toString());

      accelerationValues.remove(sortedValues.first);
    }
  }

  Map<int, double> getLastValues() {
    List<int> sortedValues = accelerationValues.keys.toList()..sort();

    List<int> lastValues = <int>[];
    for (int value in sortedValues.reversed) {
      if (lastValues.length <= References.regressionSize) {
        lastValues.add(value);
      } else {
        break;
      }
    }

    return Map.fromEntries(lastValues.map((e) => MapEntry<int, double>(e, accelerationValues[e]!)));
  }

  void getCorrelationValue() {
    Map<int, double> values = getLastValues();
    List<int> sortedTimes = values.keys.toList()..sort();
    int lastValueTime = sortedTimes.last;

    correlationValues[lastValueTime] = accelerationValues[lastValueTime]!;
  }

  List<Point<double>> mapToPoints(Map<int, double> mapToConvert) {
    List<Point<double>> points = <Point<double>>[];

    for (MapEntry<int, double> entry in mapToConvert.entries) {
      points.add(Point<double>(entry.key.toDouble(), entry.value));
    }

    // debugPrint(points.length.toString());
    return points;
  }
}
