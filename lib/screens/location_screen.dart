import 'package:flutter/material.dart';
import 'package:weather_app_demo/utilities/constants.dart';
import 'package:weather_app_demo/services/weather.dart';
import 'dart:math';
import 'package:unities_helper/unities_helper.dart';
import 'city_screen.dart';

class LocationScreen extends StatefulWidget {
  LocationScreen({this.locationWeather});
  final locationWeather;
  @override
  _LocationScreenState createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  WeatherModel weather = WeatherModel();

  late double temperatur;
  late int temperature1;
  late int temperature2;
  late String temperature;
  late String weathermessage;

  late String weatherIcon;
  late String city;
  @override
  void initState() {
    // TODO: implement initState

    updateUI(widget.locationWeather);
  }

  void updateUI(dynamic weaterData) {
    setState(() {
      if (weaterData == null) {
        temperature2 = 0;
        weatherIcon = 'Errpr';
        weathermessage = 'unable to get data';
        city = '';
        return;
      }
      double temp = weaterData['main']['temp'];

      temperatur =
          convertTemperature(Temperature.fahrenheit, Temperature.celcius, temp);

      temperature2 = temperatur.toInt();
      var condition = weaterData['weather'][0]['id'];
      weatherIcon = weather.getWeatherIcon(condition);
      print(temperature2);
      weathermessage = weather.getMessage(temperature2);
      city = weaterData['name'];
      print(weathermessage);
    });
  }

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/location_background.jpg'),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
                Colors.white.withOpacity(0.8), BlendMode.dstATop),
          ),
        ),
        constraints: BoxConstraints.expand(),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  FlatButton(
                    onPressed: () async {
                      var weatherData = await weather.getLocationWeather();
                      updateUI(weatherData);
                    },
                    child: Icon(
                      Icons.near_me,
                      size: 50.0,
                    ),
                  ),
                  FlatButton(
                    onPressed: () async {
                      var typedName = await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return CityScreen();
                          },
                        ),
                      );
                      if (typedName != Null) {
                        var weatherData =
                            await weather.getCityWeather(typedName);
                        updateUI(weatherData);
                      }
                    },
                    child: Icon(
                      Icons.location_city,
                      size: 50.0,
                    ),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.only(left: 15.0),
                child: Row(
                  children: <Widget>[
                    Text(
                      '$temperature2',
                      style: kTempTextStyle,
                    ),
                    Text(
                      '$weatherIcon',
                      style: kConditionTextStyle,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.all(15.0),
                child: Text(
                  '$weathermessage in $city ',
                  textAlign: TextAlign.center,
                  style: kMessageTextStyle,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
 //double temperature = decodedData['main']['temp'];
   //   int value = decodedData['weather'][0]['id'];
     // String city = decodedData['name'];
