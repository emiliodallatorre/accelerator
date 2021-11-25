import 'dart:math';

import 'package:accelerator/interface/widget/custom_plot.dart';
import 'package:accelerator/references.dart';
import 'package:accelerator/resources/helper/data_helper.dart';
import 'package:accelerator/resources/provider/acceleration_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_plot/flutter_plot.dart';
import 'package:sensors_plus/sensors_plus.dart';

class HomeScreen extends StatefulWidget {
  static const String route = "/homeScreen";

  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool recording = false;

  Stream<double> accelerometerStream = AccelerationProvider.accelerationStream();
  List<double> acceleratorEvents = List<double>.generate(References.regressionSize, (index) => 0.0);

  List<Point> regressionValues = <Point>[];
  List<Point> accelerometerValues = <Point>[];

  void addAcceleratorEvent(final double event) {
    acceleratorEvents.add(event);

    if(acceleratorEvents.length > References.samplingRate * 10) {
      acceleratorEvents.removeAt(0);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(References.appName),
        actions: [
          IconButton(
            icon: Icon(!recording ? Icons.play_arrow : Icons.pause),
            onPressed: () {
              if (recording) {
                // Inizia a registrare
              } else {
                // Smetti di registrare
              }

              setState(() => recording = !recording);
            },
          ),
        ],
      ),
      body: buildBody(),
    );
  }

  DataHelper? dataHelper;
  DateTime lastData = DateTime.now();

  Widget buildBody() {
    return StreamBuilder<double>(
      stream: accelerometerStream.takeWhile((_) => recording),
      builder: (BuildContext context, AsyncSnapshot<double> snapshot) {
        if (snapshot.hasData) {
          if (recording && DateTime.now().difference(lastData) > References.period) {
            addAcceleratorEvent(snapshot.data!);
            lastData = DateTime.now();

            if (acceleratorEvents.length % References.regressionSize == 0) {
              dataHelper = DataHelper(acceleratorEvents);
              regressionValues.addAll(dataHelper!.correlationData);
            }
          }

          if (dataHelper != null) {
            return ListView(
              children: [
                CustomPlot(data: dataHelper!.plainAccelerometer, xTitle: "Time", yTitle: "Y Acceleration"),
                CustomPlot(data: regressionValues, xTitle: "Time", yTitle: "Y Correlation"),
              ],
            );
          }
        }

        return Center(child: CircularProgressIndicator());
      },
    );
  }
}
