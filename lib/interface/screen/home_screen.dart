import 'package:accelerator/references.dart';
import 'package:accelerator/resources/provider/acceleration_provider.dart';
import 'package:flutter/material.dart';
import 'package:sensors_plus/sensors_plus.dart';

class HomeScreen extends StatefulWidget {
  static const String route = "/homeScreen";

  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool recording = false;

  Stream<UserAccelerometerEvent> accelerometerStream = AccelerationProvider.accelerationStream();
  List<UserAccelerometerEvent> acceleratorEvents = <UserAccelerometerEvent>[];

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

  Widget buildBody() {
    return StreamBuilder<UserAccelerometerEvent>(
      stream: accelerometerStream,
      builder: (BuildContext context, AsyncSnapshot<UserAccelerometerEvent> snapshot) {
        if (snapshot.hasData) {
          if (recording) acceleratorEvents.add(snapshot.data!);

          return Center(
            child: Text(acceleratorEvents.last.y.toString()),
          );
        }

        return Center(child: CircularProgressIndicator());
      },
    );
  }
}
