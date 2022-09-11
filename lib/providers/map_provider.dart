import 'package:flutter/cupertino.dart';
import 'package:location/location.dart';

class MapProvider extends ChangeNotifier {
  final Location location = Location();
  LocationData? userLocation;

  getUserCurrentLocation() async {
    userLocation = await location.getLocation();
  }

  onLocationChange() {
    notifyListeners();
  }
}
