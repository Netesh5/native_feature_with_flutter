import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

class geoLocator with ChangeNotifier {
  String longitude = "";
  String latitude = "";

  void getCurrentLocation() async {
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied ||
        permission == LocationPermission.deniedForever) {
      debugPrint("permission not granted");
      LocationPermission askedPermission = await Geolocator.requestPermission();
    } else {
      Position currentPosition = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.best);
      longitude = currentPosition.longitude.toString();
      latitude = currentPosition.latitude.toString();
      notifyListeners();
    }
  }
}