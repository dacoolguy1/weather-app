import 'package:flutter/material.dart';
import 'package:weather_app_demo/main.dart';
import 'package:geolocator/geolocator.dart';
import 'package:weather_app_demo/screens/location_screen.dart';
import 'package:weather_app_demo/services/location.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:weather_app_demo/services/weather.dart';
import 'package:weather_app_demo/services/networking.dart';

class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  late double lattitude;
  late double longitude;
  void initState() {
    super.initState();
    getLocationData();
  }

  void getLocationData() async {
    //LocationPermission permission = await Geolocator.requestPermission();
    //  await Geolocator.openAppSettings();
    //await Geolocator.openLocationSettings();
    WeatherModel weatherModel = WeatherModel();
    var weatherData = await weatherModel.getLocationWeather();

    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return LocationScreen(
        locationWeather: weatherData,
      );
    }));
  }

  @override
  Widget build(BuildContext context) {
    String myMargin = 'abc';
    double myMarginAsDouble;

    return Scaffold(
      body: Center(
          child: SpinKitDoubleBounce(
        color: Colors.white,
        size: 100,
      )),
    );
  }
}
