import 'package:sensors_plus/sensors_plus.dart';

class AccelerationProvider {
  static Stream<double> accelerationStream() {
    return userAccelerometerEvents.map((final UserAccelerometerEvent event) => event.y);
  }
}
