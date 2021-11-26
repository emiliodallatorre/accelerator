import 'package:sensors_plus/sensors_plus.dart';

class AccelerationProvider {
  static Stream<double> accelerationStream() {
    return userAccelerometerEvents.map((final UserAccelerometerEvent event) => double.parse(event.y.toStringAsFixed(3)));
  }
}
