import 'package:sensors_plus/sensors_plus.dart';

class AccelerationProvider {
  static Stream<UserAccelerometerEvent> accelerationStream() {
    return userAccelerometerEvents;
  }
}