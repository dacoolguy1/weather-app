import 'package:flutter/material.dart';
import 'package:weather_app_demo/main.dart';
import 'package:weather_app_demo/screens/loading_screen.dart';

import 'package:geolocator/geolocator.dart';

class Location {
  late double lattitude;
  late double longtitude;

  Future<void> getCurrentLocation() async {
    try {
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.low);
      print(position);
      lattitude = position.latitude;
      longtitude = position.longitude;
    } catch (e) {
      print(e);
    }
  }
}
