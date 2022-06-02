import 'package:geolocator/geolocator.dart';

abstract class GPS {
  static Future<Position> getCurrentPosition() {
    return Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
        timeLimit: Duration(seconds: 10));
  }
}
