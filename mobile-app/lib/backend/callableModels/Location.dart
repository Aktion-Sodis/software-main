import 'package:geolocator/geolocator.dart';
import 'package:mobile_app/models/ModelProvider.dart' as amp;

class Location {
  double? latitude;
  double? longitude;

  Location({this.latitude, this.longitude});

  Location.fromAmplifyModel(amp.Location location) {
    latitude = location.latitude;
    longitude = location.longitude;
  }

  Location.fromPosition(Position position) {
    latitude = position.latitude;
    longitude = position.longitude;
  }

  amp.Location toAmplifyModel() {
    return (amp.Location(latitude: latitude, longitude: longitude));
  }
}
