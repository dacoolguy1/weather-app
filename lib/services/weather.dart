import 'package:weather_app_demo/services/location.dart';
import 'package:weather_app_demo/services/networking.dart';

const ApIKey = '6c5373d568244d0acb590f4066a37c55';
const openWeatherURL = 'https://api.openweathermap.org/data/2.5/weather';

class WeatherModel {
  Future<dynamic> getCityWeather(String cityName) async {
    var url =
        '$openWeatherURL?q=$cityName&APPID=6c5373d568244d0acb590f4066a37c55';
    NetworkHelper networkHelper = NetworkHelper(url: url);
    var weatherData = await networkHelper.getData();
    return weatherData;
  }

  Future<dynamic> getLocationWeather() async {
    Location locs = Location();
    await locs.getCurrentLocation();
    //print(locs.getCurrentLocation());

    NetworkHelper networkHelper = NetworkHelper(
        url:
            '$openWeatherURL?lat=${locs.lattitude}&lon=${locs.longtitude}&APPID=6c5373d568244d0acb590f4066a37c55');

    var weatherData = await networkHelper.getData();
    return weatherData;
  }

  String getWeatherIcon(int condition) {
    if (condition < 300) {
      return '๐ฉ';
    } else if (condition < 400) {
      return '๐ง';
    } else if (condition < 600) {
      return 'โ๏ธ';
    } else if (condition < 700) {
      return 'โ๏ธ';
    } else if (condition < 800) {
      return '๐ซ';
    } else if (condition == 800) {
      return 'โ๏ธ';
    } else if (condition <= 804) {
      return 'โ๏ธ';
    } else {
      return '๐คทโ';
    }
  }

  String getMessage(int temp) {
    if (temp > 25) {
      return 'It\'s ๐ฆ time';
    } else if (temp > 20) {
      return 'Time for shorts and ๐';
    } else if (temp < 10) {
      return 'You\'ll need ๐งฃ and ๐งค';
    } else {
      return 'Bring a ๐งฅ just in case';
    }
  }
}
